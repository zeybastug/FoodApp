//
//  FoodInteractor.swift
//  FoodDelivery
//
//  Created by Zeynep Baştuğ on 19.05.2022.
//

import Foundation
import Alamofire
import UIKit


class FoodInteractor: PresenterToInteractorAnasayfaProtocol {
    
    var anasayfaPresenter: InteractorToPresenterAnasayfaProtocol?

    
    var cache = NSCache<AnyObject, AnyObject>()

    func tumKisileriAl()  {
        AF.request("http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php",method: .get).response { response in
            if let data  = response.data {
                do{
                    let cevap = try JSONDecoder().decode(YemekCevap.self,from: data)
                    if let liste = cevap.yemekler {
                        self.anasayfaPresenter?.presenteraVeriGonder(foodsList: liste)
                    }
                }catch{
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    
    func imageForUrl(urlString: String, completionHandler:@escaping (_ image: UIImage?, _ url: String) -> ()) {
        let data: NSData? = self.cache.object(forKey: urlString as AnyObject) as? NSData

        if let imageData = data {
            let image = UIImage(data: imageData as Data)
            DispatchQueue.main.async {
                completionHandler(image, urlString)
            }
            return
        }

        let downloadTask: URLSessionDataTask = URLSession.shared.dataTask(with: URL.init(string: urlString)!) { (data, response, error) in
            if error == nil {
                if data != nil {
                    let image = UIImage.init(data: data!)
                    self.cache.setObject(data! as AnyObject, forKey: urlString as AnyObject)
                    DispatchQueue.main.async {
                        completionHandler(image, urlString)
                    }
                }
            } else {
                completionHandler(nil, urlString)
            }
        }
        downloadTask.resume()
    }
    
    
    
    
}

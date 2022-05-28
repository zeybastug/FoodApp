//
//  DetailsInteractor.swift
//  FoodDelivery
//
//  Created by Zeynep Baştuğ on 21.05.2022.
//

import Foundation
import Alamofire

class DetailsInteractor: PresenterToInteractorDetailsProtocol {
    
    var presenterIn:InteractorToPresenterDetailsProtocol?
    
    func sendAddToCartRequest(food:CartModel) {
        let params: Parameters = ["yemek_adi":food.yemek_adi, "yemek_resim_adi":food.yemek_resim_adi, "yemek_siparis_adet":food.yemek_siparis_adet, "yemek_fiyat":food.yemek_fiyat, "kullanici_adi":food.kullanici_adi]
        AF.request("http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php"
                   , method: .post, parameters: params, headers: nil).validate(statusCode: 200 ..< 299).responseJSON { AFdata in
            do {
                guard let jsonObject = try JSONSerialization.jsonObject(with: AFdata.data!) as? [String: Any] else {
                    print("Error: Cannot convert data to JSON object")
                    return
                }
                guard let prettyJsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) else {
                    print("Error: Cannot convert JSON object to Pretty JSON data")
                    return
                }
                guard let prettyPrintedJson = String(data: prettyJsonData, encoding: .utf8) else {
                    print("Error: Could print JSON in String")
                    return
                }
                
                print(prettyPrintedJson)
            } catch {
                print("Error: Trying to convert JSON data to string")
                return
            }
        }
    }
    
}

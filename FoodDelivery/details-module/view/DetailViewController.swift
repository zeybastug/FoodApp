//
//  DetailsViewController.swift
//  FoodDelivery
//
//  Created by Zeynep Baştuğ on 21.05.2022.
//

import UIKit
import SwiftUI

class DetailViewController: UIViewController {
    
    var food:Yemek = Yemek.init(yemek_id: "", yemek_adi: "", yemek_resim_adi: "", yemek_fiyat: "")
    
    var mainVC:ViewController?
    
    var presenter:ViewToPresenterDetailsProtocol?

    
    @IBOutlet weak var foodImage: UIImageView!
    
    @IBOutlet weak var foodPrice: UILabel!
    
    @IBOutlet weak var foodName: UILabel!
    
    @IBOutlet weak var foodAmount: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Food Hub"
        
        let appearance = UINavigationBarAppearance()
        
        appearance.backgroundColor = UIColor(named: "MainColor")
        
        appearance.titleTextAttributes = [.foregroundColor: UIColor(named: "NaviWritingColor")!, NSAttributedString.Key.font : UIFont(name: "Lobster-Regular", size: 25)!]
        
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.isTranslucent = true
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        foodAmount.text = "0"
        DetailsRouter.createModule(ref: self)
        
        mainVC?.anasayfaPresenterNesnesi?.anasayfaInteractor?.imageForUrl(
            urlString: "http://kasimadalan.pe.hu/yemekler/resimler/" + (food.yemek_resim_adi),
            completionHandler: { (image, url) in
                if image != nil {
                    self.foodImage.image = image
                }
            }
 )
        foodName.text = food.yemek_adi
        foodPrice.text = food.yemek_fiyat + "₺"
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
         if segue.identifier == "detailsToCartButton" {
            let gidilecekVC = segue.destination as! CartViewController?
            gidilecekVC?.mainVC = mainVC
        }
    }

    @IBAction func stepperOnClick(_ sender: UIStepper) {
        self.foodAmount.text = Int(sender.value).description
    }
    
    @IBAction func addToCart(_ sender: Any) {
        
//        let id : Int = Int(food.yemek_id) ?? 0
//        let fiyat : Int = Int(food.yemek_fiyat) ?? 0
        let adet : Int = Int(foodAmount.text!) ?? 0
        
        presenter?.interactor?.sendAddToCartRequest(food:CartModel(sepet_yemek_id: food.yemek_id, yemek_adi: food.yemek_adi, yemek_resim_adi: food.yemek_resim_adi, yemek_fiyat: food.yemek_fiyat , yemek_siparis_adet: String(adet), kullanici_adi: "Zeynep"))
    }
}

extension DetailViewController : PresenterToViewDetailsProtocol {
    
}

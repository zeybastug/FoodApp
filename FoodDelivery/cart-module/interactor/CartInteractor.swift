//
//  CartInteractor.swift
//  FoodDelivery
//
//  Created by Zeynep Baştuğ on 22.05.2022.
//

import Foundation
import Alamofire

class CartInteractor: PresenterToInteractorCartProtocol {
    
    var presenter:InteractorToPresenterCartProtocol?
    
    func getFoodFromCart() {
         let params:Parameters = ["kullanici_adi":"Zeynep"]
        AF.request("http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php"
                   , method: .post, parameters: params).response { response in
            if let data  = response.data {
                do{
                    let cevap = try JSONDecoder().decode(CartModelResponse.self,from: data)
                    self.presenter?.updateFoodFromInteractor(foodList: cevap.sepet_yemekler)
                    
                }catch{ print(error.localizedDescription) }
            }
        }
    }
    
    func deleteFood(id: Int) {
        let params:Parameters = ["sepet_yemek_id":id,"kullanici_adi" : "Zeynep"]
        
        AF.request("http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php",method: .post,parameters: params).response { response in
            if let data  = response.data {
                do{
                    let cevap = try JSONSerialization.jsonObject(with: data)
                    print(cevap)
                    self.getFoodFromCart()
                }catch{ print(error.localizedDescription) }
            }
        }
    }
}

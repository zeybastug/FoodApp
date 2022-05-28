//
//  CartModelResponse.swift
//  FoodDelivery
//
//  Created by Zeynep Baştuğ on 22.05.2022.
//

import Foundation

class CartModelResponse :Codable{
    
    var sepet_yemekler:Array<CartModel>
    var success:Int
    
     init(sepet_yemekler: Array<CartModel>, success: Int) {
        self.sepet_yemekler = sepet_yemekler
        self.success = success
    }
}

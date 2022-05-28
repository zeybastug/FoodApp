//
//  CartRouter.swift
//  FoodDelivery
//
//  Created by Zeynep Baştuğ on 22.05.2022.
//

import Foundation

class CartRouter {
    
    static func createModule(ref:CartViewController){
        
        let pres = CartPresenter()
        ref.presenter = pres
        let inte : CartInteractor = CartInteractor()
        pres.interactor = inte
        pres.interactor?.presenter = pres
        pres.view = ref
    }

}

//
//  CartProtocols.swift
//  FoodDelivery
//
//  Created by Zeynep Baştuğ on 22.05.2022.
//

import Foundation

    
    //Ana protocoller
    protocol ViewToPresenterCartProtocol {
        var interactor:PresenterToInteractorCartProtocol? {get set}
        var view:PresenterToViewCartProtocol? {get set}
        
        func delete(id: Int)
        
    }

    protocol PresenterToInteractorCartProtocol {
        var presenter : InteractorToPresenterCartProtocol? {get set}
        
        func getFoodFromCart()
        
        func deleteFood(id: Int) 
        
    }

    //Taşıyıcı protocoller
    protocol InteractorToPresenterCartProtocol {
        func updateFoodFromInteractor(foodList: Array<CartModel>)
        
    }

    protocol PresenterToViewCartProtocol {
        
        func updateFoodList(foodList: Array<CartModel>)
        
    }

    ////Router protocol
    protocol PresenterToRouterCartProtocol {
        //static func createModule(ref:ViewController)
    }

    


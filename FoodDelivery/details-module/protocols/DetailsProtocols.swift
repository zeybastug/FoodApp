//
//  DetailsProtocols.swift
//  FoodDelivery
//
//  Created by Zeynep Baştuğ on 21.05.2022.
//

import Foundation

import UIKit



//Ana protocoller
protocol ViewToPresenterDetailsProtocol {
    var interactor:PresenterToInteractorDetailsProtocol? {get set}
    var view:PresenterToViewDetailsProtocol? {get set}
    

    
}

protocol PresenterToInteractorDetailsProtocol {
    var presenterIn : InteractorToPresenterDetailsProtocol? {get set}
    
    func sendAddToCartRequest(food:CartModel)
    
}

//Taşıyıcı protocoller
protocol InteractorToPresenterDetailsProtocol {
    
}

protocol PresenterToViewDetailsProtocol {
    
}

////Router protocol
protocol PresenterToRouterDetailsProtocol {
    //static func createModule(ref:ViewController)
}

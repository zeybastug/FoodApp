//
//  AnasayfaProtocol.swift
//  FoodDelivery
//
//  Created by Zeynep Baştuğ on 19.05.2022.
//

import Foundation
import UIKit

//Ana protocoller
protocol ViewToPresenterAnasayfaProtocol {
    var anasayfaInteractor:PresenterToInteractorAnasayfaProtocol? {get set}
    var anasayfaView:PresenterToViewAnasayfaProtocol? {get set}
    
    func loadFood()
}

protocol PresenterToInteractorAnasayfaProtocol {
    var anasayfaPresenter:InteractorToPresenterAnasayfaProtocol? {get set}
    
    func imageForUrl(urlString: String,completionHandler :@escaping (_ image: UIImage?, _ url: String) -> ())
    func tumKisileriAl()
}

//Taşıyıcı protocoller
protocol InteractorToPresenterAnasayfaProtocol {
    func presenteraVeriGonder(foodsList:Array<Yemek>)
}

protocol PresenterToViewAnasayfaProtocol {
    func vieweVeriGonder(foodList:Array<Yemek>)
}

////Router protocol
protocol PresenterToRouterAnasayfaProtocol {
    //static func createModule(ref:ViewController)
}

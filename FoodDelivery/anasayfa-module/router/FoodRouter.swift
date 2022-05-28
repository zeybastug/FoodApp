//
//  FoodRouter.swift
//  FoodDelivery
//
//  Created by Zeynep Baştuğ on 20.05.2022.
//

import Foundation

class FoodRouter : PresenterToRouterAnasayfaProtocol {
    static func createModule(ref: ViewController) {
        let presenter = AnasayfaPresenter()
        
        //View
        ref.anasayfaPresenterNesnesi = presenter
        
        let interactor = FoodInteractor()
        
        //Presenter
        ref.anasayfaPresenterNesnesi?.anasayfaInteractor = interactor
        ref.anasayfaPresenterNesnesi?.anasayfaView = ref
        
        //Interactor
        presenter.anasayfaInteractor?.anasayfaPresenter = presenter
    }
}

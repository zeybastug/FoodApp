//
//  DetailsRouter.swift
//  FoodDelivery
//
//  Created by Zeynep Baştuğ on 21.05.2022.
//

import Foundation

class DetailsRouter: PresenterToRouterDetailsProtocol {
    
    static func createModule(ref : DetailViewController){
    
    let pre = DetailsPresenter()
    
    ref.presenter = pre
    
    pre.interactor = DetailsInteractor()
    
    pre.interactor?.presenterIn = pre
    
    pre.view = ref

}
}



//
//  DetailsPresenter.swift
//  FoodDelivery
//
//  Created by Zeynep Baştuğ on 21.05.2022.
//

import Foundation

class DetailsPresenter : ViewToPresenterDetailsProtocol {
    
    var view:PresenterToViewDetailsProtocol?
    var interactor:PresenterToInteractorDetailsProtocol?
    
    
}

extension DetailsPresenter : InteractorToPresenterDetailsProtocol {
    
}

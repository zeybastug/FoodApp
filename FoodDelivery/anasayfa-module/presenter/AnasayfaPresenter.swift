//
//  AnsayfaPresenter.swift
//  FoodDelivery
//
//  Created by Zeynep Baştuğ on 19.05.2022.
//

import Foundation
import UIKit


class AnasayfaPresenter: ViewToPresenterAnasayfaProtocol  {
    
    var anasayfaInteractor: PresenterToInteractorAnasayfaProtocol?
    
    var anasayfaView: PresenterToViewAnasayfaProtocol?
    
    func loadFood() {
        anasayfaInteractor?.tumKisileriAl()
    }
    
    
        
}
extension AnasayfaPresenter : InteractorToPresenterAnasayfaProtocol {
    func presenteraVeriGonder(foodsList: Array<Yemek>) {
        anasayfaView?.vieweVeriGonder(foodList: foodsList)
    }
}

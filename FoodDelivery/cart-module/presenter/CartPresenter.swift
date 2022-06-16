//
//  CartPresenter,.swift
//  FoodDelivery
//
//  Created by Zeynep Baştuğ on 22.05.2022.
//

import Foundation

class CartPresenter: ViewToPresenterCartProtocol{
    
    var interactor:PresenterToInteractorCartProtocol?
    var view:PresenterToViewCartProtocol?
    
    func delete(id: Int) {
        interactor?.deleteFood(id: id)
    }
}

extension CartPresenter: InteractorToPresenterCartProtocol{
    
    func updateFoodFromInteractor(foodList: Array<CartModel>)
    {
        view?.updateFoodList(foodList: foodList)
    }
    
    
}

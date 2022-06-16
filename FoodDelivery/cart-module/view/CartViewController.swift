//
//  CartViewController.swift
//  FoodDelivery
//
//  Created by Zeynep Baştuğ on 22.05.2022.
//

import UIKit

class CartViewController: UIViewController {
    
    var presenter:CartPresenter?
    
    var foodCartList:Array<CartModel> = []
    
    var mainVC:MainViewController?

    @IBOutlet weak var cartTableView: UITableView!

    @IBOutlet weak var cartLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CartRouter.createModule(ref: self)
        cartTableView.delegate = self
        cartTableView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter?.interactor?.getFoodFromCart()
        
    }
    
   func mergeFoods(foodCartList:Array<CartModel>) -> Array<CartModel>
    {
        
        var resultFoodList:Array<CartModel> = []
        for cartModel in foodCartList {
            if (resultFoodList.contains(where: { $0.yemek_adi == cartModel.yemek_adi }) )
            {
                if let temp = resultFoodList.filter({$0.yemek_adi == cartModel.yemek_adi}).first {
                    if let amo = Int(temp.yemek_siparis_adet)
                    {
                        if let amo_2 = Int(cartModel.yemek_siparis_adet) {
                            let result = amo + amo_2
                            resultFoodList.filter({$0.yemek_adi == cartModel.yemek_adi}).first?.yemek_siparis_adet = String(result)
                        }
                    }
                   
                }
            }
            else {
                resultFoodList.append(cartModel)
            }
            for food in resultFoodList {
                    if let amo = Int(food.yemek_siparis_adet)
                    {
                        if let initPrice = mainVC?.yemeklerListe.filter({$0.yemek_adi == food.yemek_adi}).first?.yemek_fiyat {
                            food.yemek_fiyat = String(Int(initPrice)! * amo)
                        }
                      
                    }
                
            }
        }
        return resultFoodList
    }

}

extension CartViewController : UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodCartList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
         return 100 // custom height
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let urun = foodCartList[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cartCell", for: indexPath) as! CartTableViewCell
        
       // cell.yemekResimIsim.image = UIImage(named: urun.yemek_resim_adi)
        cell.cartName.text = urun.yemek_adi
        cell.cartPrice.text = "\(urun.yemek_fiyat)₺"
        cell.cartAmount.text = urun.yemek_siparis_adet + " adet"
        
        mainVC?.anasayfaPresenterNesnesi?.anasayfaInteractor!.imageForUrl(urlString: "http://kasimadalan.pe.hu/yemekler/resimler/" + urun.yemek_resim_adi, completionHandler: { (image, url) in
                   if image != nil {
                       cell.cartImage.image = image
                   }
        })
        return cell
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let actionDelete = UIContextualAction(style: .destructive, title: "Sil"){ (action,view,void) in
            let food = self.foodCartList[indexPath.row]
            
            let alert = UIAlertController(title: "Silme İşlemi", message: "\(food.yemek_adi) silinsin mi?", preferredStyle: .alert)
            
            let actionAbort = UIAlertAction(title: "İptal", style: .cancel){ action in }
            alert.addAction(actionAbort)
            
            let evetAction = UIAlertAction(title: "Evet", style: .destructive){ action in
                self.presenter?.delete(id: Int(food.sepet_yemek_id)!)
            }
            alert.addAction(evetAction)
            self.present(alert, animated: true)
        }
        return UISwipeActionsConfiguration(actions: [actionDelete])
    }
 
}

extension CartViewController: PresenterToViewCartProtocol {
    
    func updateFoodList(foodList: Array<CartModel>) {
        self.foodCartList = mergeFoods(foodCartList: foodList)
        DispatchQueue.main.async {
            self.cartTableView.reloadData()
        }
    }
}

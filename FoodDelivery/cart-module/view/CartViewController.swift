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
    
    var mainVC:ViewController?

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
        self.foodCartList = foodList
        DispatchQueue.main.async {
            self.cartTableView.reloadData()
        }
    }
}

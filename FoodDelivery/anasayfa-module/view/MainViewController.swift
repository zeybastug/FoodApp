//
//  ViewController.swift
//  FoodDelivery
//
//  Created by Zeynep Baştuğ on 19.05.2022.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var barButtonToCart: UIBarButtonItem!
    
    var yemeklerListe: [Yemek] = []
    

    @IBOutlet weak var tableView: UITableView!
    
    var anasayfaPresenterNesnesi:ViewToPresenterAnasayfaProtocol? //  :(
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        FoodRouter.createModule(ref: self)
        
        self.navigationItem.title = "Food Hub"
        
        let appearance = UINavigationBarAppearance()
        
        appearance.backgroundColor = UIColor(named: "MainColor")
        
        appearance.titleTextAttributes = [.foregroundColor: UIColor(named: "NaviWritingColor")!, NSAttributedString.Key.font : UIFont(name: "Lobster-Regular", size: 25)!]
        
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.isTranslucent = true
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
    override func viewWillAppear(_ animated: Bool) {
        anasayfaPresenterNesnesi?.loadFood()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetails" {
            if let food = sender as? Yemek {
                let gidilecekVC = segue.destination as! DetailViewController?
                gidilecekVC?.food = food
                gidilecekVC?.mainVC = self
            }
        }
        else if segue.identifier == "buttonToCart" {
            let gidilecekVC = segue.destination as! CartViewController?
            gidilecekVC?.mainVC = self

        }
        
    }
}

extension MainViewController : UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return yemeklerListe.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
         return 100 // custom height
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let urun = yemeklerListe[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath) as! TableViewCell
        
       // cell.yemekResimIsim.image = UIImage(named: urun.yemek_resim_adi)
        cell.yemekAdi.text = urun.yemek_adi
        cell.yemekFiyat.text = "\(urun.yemek_fiyat) ₺"
        
        anasayfaPresenterNesnesi?.anasayfaInteractor!.imageForUrl(urlString: "http://kasimadalan.pe.hu/yemekler/resimler/" + urun.yemek_resim_adi, completionHandler: { (image, url) in
                   if image != nil {
                       cell.yemekResimIsim.image = image
                   }
        })
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let food = yemeklerListe[indexPath.row]
        performSegue(withIdentifier: "toDetails", sender: food)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension MainViewController : PresenterToViewAnasayfaProtocol {
    func vieweVeriGonder(foodList: Array<Yemek>) {
        self.yemeklerListe = foodList
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

//
//  TableViewCell.swift
//  FoodDelivery
//
//  Created by Zeynep Baştuğ on 19.05.2022.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var yemekAdi: UILabel!
    
    @IBOutlet weak var yemekFiyat: UILabel!
    
    @IBOutlet weak var yemekResimIsim: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

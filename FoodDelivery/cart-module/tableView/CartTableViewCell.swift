//
//  CartTableViewCell.swift
//  FoodDelivery
//
//  Created by Zeynep Baştuğ on 22.05.2022.
//

import UIKit

class CartTableViewCell: UITableViewCell {

    @IBOutlet weak var cartImage: UIImageView!
    
    @IBOutlet weak var cartName: UILabel!
    
    @IBOutlet weak var cartAmount: UILabel!
    
    @IBOutlet weak var cartPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

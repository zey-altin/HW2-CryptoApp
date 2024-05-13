//
//  CoinCell.swift
//  HW2_Crypto_App
//
//  Created by Zeynep Nur Altın on 10.05.2024.
//

import UIKit
import Kingfisher

class CoinCell: UITableViewCell {
    
    static let identifier = "CoinCell"
    
    @IBOutlet weak var coinImage: UIImageView!
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var changeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    public func configure(withModel model : Coins) {
        self.symbolLabel.text = model.symbol
        self.nameLabel.text = model.name

        if let price = Double(model.price!) {
            var formattedPrice = "$"
            if price > 1.0 {
                formattedPrice += String(format: "%.2f", price)
            } else {
                formattedPrice += String(format: "%.6f", price)
            }
            self.priceLabel.text = formattedPrice
        }
        
        if let change = Double(model.change!){
            var modifiedChange = "% " + "\(change)"
            if change < 0 {
                modifiedChange = "▼ " + modifiedChange
                self.changeLabel.textColor = .red
            } else {
                modifiedChange = "▲ " + modifiedChange
                self.changeLabel.textColor = .green
            }
            self.changeLabel.text = modifiedChange
        }
        
        if var urlString = model.iconUrl{
            if urlString.contains("svg"){
                urlString = urlString.replacingOccurrences(of: "svg", with: "png")
            }
            if let url = URL(string: urlString){
                self.coinImage.kf.setImage(with: url)
            }
        }
    }
}


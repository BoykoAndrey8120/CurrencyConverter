//
//  CurrencyTableViewCell.swift
//  CurrencyConverter
//
//  Created by Andrey Boyko on 06.12.2021.
//

import UIKit


class CurrencyTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLablCell: UILabel!
   
    override func awakeFromNib() {
        super.awakeFromNib()
       // .....
    }
    func apply(title: String) {
        titleLablCell.text = title
    }
}

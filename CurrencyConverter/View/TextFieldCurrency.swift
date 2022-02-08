//
//  TextFieldCurrency.swift
//  CurrencyConverter
//
//  Created by Andrey Boyko on 16.11.2021.
//

import UIKit

class TextFieldCurrency: UITextField {
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.backgroundColor = UIColor(named: "ColorOfTextField")
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 4
        self.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
}
}

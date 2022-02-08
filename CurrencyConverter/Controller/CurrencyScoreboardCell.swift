//
//  CurrencyScoreboardCell.swift
//  CurrencyConverter
//
//  Created by Andrey Boyko on 14.12.2021.
//

import UIKit

//protocol CurrencyScoreboardCellDelegat: class {
//    func textFieldDidBeginEditing(_ textField: UITextField, cell: CurrencyScoreboardCell)
//}

class CurrencyScoreboardCell: UITableViewCell, UITextFieldDelegate {
    
//    weak var delegate: CurrencyScoreboardCellDelegat?

    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var scoreboardLabel: UILabel!
    @IBOutlet weak var scoreboardTextField: TextFieldCurrency!
    
   
    override func awakeFromNib() {
        super.awakeFromNib()
        scoreboardTextField.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func configure(currency: CurrencyConversion) {
        scoreboardLabel.text = currency.name
        scoreboardTextField.text = currency.value
        currency.delegate = self
    }
}


extension CurrencyScoreboardCell: ValueChangedDelegat {
    func valueChanged(text: String, nameCurrency: String) {
      //  let dictionaryCurrency: [String: String] = [text: nameCurrency]
        scoreboardTextField.text = text
       
    }
}


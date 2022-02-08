//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Andrey Boyko on 11.11.2021.
//

import UIKit

protocol ValueChangedDelegat: class {
    func valueChanged(text: String, nameCurrency: String)
}

class ViewController: UIViewController, UITextFieldDelegate {
    
    //    @IBOutlet weak var addCurrency: UIButton!
    @IBOutlet weak var lastUpdateContent: UILabel!
    
    @IBOutlet weak var scoreboardTableView: UITableView!
    @IBOutlet weak var viewScoreboard: UIView!
    @IBOutlet weak var viewCurrency: UIView!
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var imageView3: UIImageView!
    @IBOutlet weak var button: UIButton!
    
    
    weak var delegatValue: ValueChangedDelegat?
    var dateFormatter = DateFormatter()
    var currency = Currency()
    var rate: String?
    var baseCurrency: String?
    var indexPathArray: [Int] = []
    var currencyItems: [CurrencyConversion] = [CurrencyConversion(name: "USD", sale: nil), CurrencyConversion(name: "EUR", sale: nil), CurrencyConversion(name: "RUR", sale: nil)]
    var baseValue: String?
    
    // MARK: Lifecycle
    override func viewDidAppear(_ animated: Bool) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateFormatter.dateFormat = "dd MMM YYYY h:mm a"
        lastUpdateContent.text = dateFormatter.string(from: currency.dateLastUpdata)
        
        scoreboardTableView.delegate = self
        scoreboardTableView.dataSource = self
        scoreboardTableView.register(UINib(nibName: "CurrencyScoreboardCell", bundle: nil), forCellReuseIdentifier: "CurrencyScoreboardCell")
        scoreboardTableView.reloadData()
        
    }
    override func viewDidLayoutSubviews() {
        if let myImage = UIImage(named: "Image-1"),
           let myImage2 = UIImage(named: "Image-2"),
           let myImage3 = UIImage(named: "Image-3") {
            imageView1.image = myImage.withRenderingMode(.alwaysTemplate)
            imageView2.image = myImage2.withRenderingMode(.alwaysTemplate)
            imageView3.image = myImage3.withRenderingMode(.alwaysTemplate)
        }
        
        imageView1.tintColor = UIColor(named: "Color-1")
        imageView2.tintColor = UIColor(named: "Color-2")
        imageView3.tintColor = UIColor(named: "Color-3")
        
        viewCurrency.layer.cornerRadius = 10
        viewCurrency.layer.shadowRadius = 4
        viewCurrency.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.15).cgColor
        viewCurrency.layer.shadowOffset = CGSize(width: 0, height: 4)
        viewCurrency.layer.shadowOpacity = 1
        
    }
    
    // MARK: Actions
    
    @IBAction func showExchangeRates(_ sender: Any) {
        
        button.isHidden = true
        
    }
    
    @IBAction func addCurrency(_ sender: UIButton) {
        
        guard let currencyVC = storyboard?.instantiateViewController(withIdentifier: "CurrencyViewController") as? CurrencyViewController else {
            return
        }
        
        currencyVC.delegate = self
        self.present(currencyVC, animated: true, completion: nil)
    }
}

func textFildsInfo(name: CurrencyConversion, array: Currency) -> String {
    for code in array.array {
        if name.name == code.currencyName {
            return code.buy
        }
        
    }
    return ""
}

extension ViewController {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.isEditing {
            currencyItems.forEach {
                if $0.name == baseCurrency {
                    for num in currencyItems {
                        if num.name == baseCurrency {
                            baseValue = $0.value + string
                            
                        }
                    }
                } else {
                    $0.value = $0.fill2(name: $0.name, value: $0.value, baseExchange: baseCurrency, baseValue: baseValue)
                }
            }
        }
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        currencyItems.forEach { if $0.value == textField.text {
            $0.value = "1"
            baseCurrency = $0.name
        }
        }
    }
}

//MARK: - CurrencyTableViewControllerDelegate

extension ViewController: CurrencyViewControllerDelegate {
    
    func currencySelected(currency: String) {
        currencyItems.append(CurrencyConversion(name: currency, sale: nil))
        scoreboardTableView.reloadData()
        
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencyItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyScoreboardCell") as! CurrencyScoreboardCell
        cell.scoreboardTextField.delegate = self
        cell.configure(currency: currencyItems[indexPath.row])
        indexPathArray.append(cell.hash)
        
        return cell
    }
}


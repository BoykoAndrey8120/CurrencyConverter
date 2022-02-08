//
//  CurrencyViewController.swift
//  CurrencyConverter
//
//  Created by Andrey Boyko on 06.12.2021.
//

import UIKit

protocol CurrencyViewControllerDelegate: AnyObject {
    func currencySelected(currency: String)
}

class CurrencyViewController: UIViewController {
    
    
    
    @IBOutlet weak var currencyTableView: UITableView!
    
    weak var delegate: CurrencyViewControllerDelegate?
    let isoCurrency = NSLocale.isoCurrencyCodes
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
    }
    private func setupTableView() {
        currencyTableView.delegate = self
        currencyTableView.dataSource = self
        currencyTableView.register(UINib(nibName: "CurrencyTableViewCell", bundle: nil), forCellReuseIdentifier: "CurrencyTableViewCell")
    }
    
}

extension CurrencyViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.currencySelected(currency: isoCurrency[indexPath.row])
        self.dismiss(animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        isoCurrency.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CurrencyTableViewCell") as! CurrencyTableViewCell
        cell.apply(title: isoCurrency[indexPath.row])
        
        return cell
    }
}

//
//  SmallCartViewController.swift
//  ObservableExample
//
//  Created by Andrei Hogea on 01/03/2019.
//  Copyright © 2019 Nodes. All rights reserved.
//

import UIKit

class SmallCartViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var productsLabel: UILabel! {
        didSet {
            productsLabel.text = "0 prod."
        }
    }
    @IBOutlet weak var priceLabel: UILabel!
    
    private var productsObserver: Observer<[Product]>!
    private var observerReference: Int!
    
    // MARK: - Init
    
    class func instantiate(productsObserver: Observer<[Product]>) -> SmallCartViewController {
        let name = "\(SmallCartViewController.self)"
        let storyboard = UIStoryboard(name: name, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: name) as! SmallCartViewController
        vc.productsObserver = productsObserver
        return vc
    }
    
    deinit {
        productsObserver.removeObserve(with: observerReference)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.lightGray.withAlphaComponent(0.2)
        
        observerReference = productsObserver.observe { (products) in
            self.productsLabel.text = "\(products.count) prod."
            var price = 0.0
            products.forEach({ price += $0.price })
            self.priceLabel.text = Current.priceFormatter.string(from: price as NSNumber)!
        }
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        view.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.3).cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = view.bounds.height / 2
        view.clipsToBounds = true
    }
    
}

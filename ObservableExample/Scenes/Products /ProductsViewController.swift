//
//  ProductsViewController.swift
//  ObservableExample
//
//  Created by Andrei Hogea on 01/03/2019.
//  Copyright © 2019 Nodes. All rights reserved.
//

import UIKit

class ProductsViewController: UIViewController {
    
    // MARK: - IBOutlets
        
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
            tableView.tableFooterView = UIView()
            tableView.rowHeight = UITableView.automaticDimension

            tableView.register(UINib(nibName: "\(ProductCell.self)", bundle: nil),
                               forCellReuseIdentifier: "\(ProductCell.self)")
        }
    }
    
    // MARK: - Properties
    
    var category: ProductCategory!
    var productsObserver: Observer<[Product]>!

    private var products: [Product] = []
    
    // MARK: - Init
    
    class func instantiate(category: ProductCategory, productsObserver: Observer<[Product]>) -> ProductsViewController {
        let name = "\(ProductsViewController.self)"
        let storyboard = UIStoryboard(name: name, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: name) as! ProductsViewController
        vc.category = category
        vc.productsObserver = productsObserver
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = category.name

        products = Current.catalog.fetchProducts(categoryId: category.id)
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource

extension ProductsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(ProductCell.self)", for: indexPath) as! ProductCell
        
        let product = products[indexPath.row]
        cell.productNameLabel.text = product.name
        
        if let price = Current.priceFormatter.string(from: product.price as NSNumber) {
            cell.productPriceLabel.text = "\(price)"
        }
        
        return cell
    }
    
    
}

// MARK: - UITableViewDelegate

extension ProductsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let product = products[indexPath.row]
        var productsInCart = productsObserver.getValue() as [Product]
        productsInCart.append(product)
        productsObserver.update(productsInCart)
        
    }
}

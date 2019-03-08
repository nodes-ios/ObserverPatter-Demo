//
//  ViewController.swift
//  ObservableExample
//
//  Created by Andrei Hogea on 01/03/2019.
//  Copyright © 2019 Nodes. All rights reserved.
//

import UIKit

class ProductCategoriesViewController: UIViewController {

    // MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
            tableView.tableFooterView = UIView()
            tableView.rowHeight = UITableView.automaticDimension
            
            tableView.register(UINib(nibName: "\(ProductCategoryCell.self)", bundle: nil),
                               forCellReuseIdentifier: "\(ProductCategoryCell.self)")
        }
    }
    
    // MARK: - Properties
    
    private var categories: [ProductCategory] = []
    
    // MARK: - Init
    
    class func instantiate() -> ProductCategoriesViewController {
        let name = "\(ProductCategoriesViewController.self)"
        let storyboard = UIStoryboard(name: name, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: name) as! ProductCategoriesViewController
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Categories"
        
        categories = Current.catalog.fetchCategories()
        
        tableView.reloadData()

    }

}

// MARK: - UITableViewDataSource

extension ProductCategoriesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(ProductCategoryCell.self)", for: indexPath) as! ProductCategoryCell
        
        let category = categories[indexPath.row]
        cell.categoryNameLabel.text = category.name
        
        return cell
    }
    
    
}

// MARK: - UITableViewDelegate

extension ProductCategoriesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let category = categories[indexPath.row]
        let productVC = ProductsViewController.instantiate(category: category)
        navigationController?.pushViewController(productVC,
                                                 animated: true)
    }
}

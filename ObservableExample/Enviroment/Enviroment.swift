//
//  Enviroment.swift
//  ObservableExample
//
//  Created by Andrei Hogea on 01/03/2019.
//  Copyright © 2019 Nodes. All rights reserved.
//

import Foundation

var Current = Enviroment()

struct Enviroment {
    
    var priceFormatter: NumberFormatter = NumberFormatter.makeDefaultPriceFormatter()
    var catalog = Catalog()
    
}

extension NumberFormatter {
    
    static func makeDefaultPriceFormatter() -> NumberFormatter {
        let formatter = NumberFormatter()
        formatter.locale = Locale.init(identifier: "en_DK")
        formatter.numberStyle = .currency
        return formatter
        
    }
    
}

struct Catalog {

    func fetchCategories() -> [ProductCategory] {
        let chocolate = ProductCategory(id: 1, name: "Chocolate")
        let popcorn = ProductCategory(id: 2, name: "Popcorn")
        let crisps = ProductCategory(id: 3, name: "Crisps")
        let sodas = ProductCategory(id: 4, name: "Sodas")
        
        return [chocolate, popcorn, crisps, sodas]
    }
    
    func fetchProducts(categoryId: Int) -> [Product] {
        
        switch categoryId {
        case 1: // chocolate
            let mars = Product(id: 0, name: "Mars", price: 1.2)
            let milka = Product(id: 0, name: "Milka", price: 2.0)
            let bounty = Product(id: 0, name: "Bounty", price: 1.3)
            let oreo = Product(id: 0, name: "Oreo", price: 3.75)
            
            return [mars, milka, bounty, oreo]
        case 2: // popcorn
            let p1 = Product(id: 0, name: "w Salt", price: 1.5)
            let p2 = Product(id: 0, name: "w Salt&Peper", price: 1.75)
            let p3 = Product(id: 0, name: "w Caramel", price: 3)
            let p4 = Product(id: 0, name: "w Cayene", price: 3)
            
            return [p1, p2, p3, p4]
        case 3: // Crisps
            let p1 = Product(id: 0, name: "Doritos", price: 2.5)
            let p2 = Product(id: 0, name: "Kims", price: 1.5)
            let p3 = Product(id: 0, name: "Lays", price: 2.45)
            let p4 = Product(id: 0, name: "Kettle", price: 3)
            
            return [p1, p2, p3, p4]
        case 4: // Soda
            let p1 = Product(id: 0, name: "Coke", price: 1.95)
            let p2 = Product(id: 0, name: "Coke Light", price: 1.95)
            let p3 = Product(id: 0, name: "Fanta", price: 1.95)
            let p4 = Product(id: 0, name: "Sprite", price: 1.95)

            return [p1, p2, p3, p4]
        default:
            return []
        }
        
    }
    
}

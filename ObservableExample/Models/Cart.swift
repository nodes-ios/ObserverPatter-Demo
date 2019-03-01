//
//  Cart.swift
//  ObservableExample
//
//  Created by Andrei Hogea on 01/03/2019.
//  Copyright © 2019 Nodes. All rights reserved.
//

import Foundation

class Cart {
    
    var products: [Product] = []
    var totalAmount: Double {
        var amount = 0.0
        products.forEach({ amount += $0.price })
        return amount
    }
    
}

//
//  Disposable.swift
//  ObservableExample
//
//  Created by Andrei Hogea on 17/03/2019.
//  Copyright © 2019 Nodes. All rights reserved.
//

import Foundation

class Disposable {
    
    /// callback called automatically on deinit
    private let dispose: () -> ()
    
    init(_ dispose: @escaping () -> ()) {
        self.dispose = dispose
    }
    
    deinit {
        dispose()
    }
    
    /// call add when having multiple Observables in the same class
    func add(to disposable: inout [Disposable]) {
        disposable.append(self)
    }
}

//
//  Observer.swift
//  ObservableExample
//
//  Created by Andrei Hogea on 01/03/2019.
//  Copyright © 2019 Nodes. All rights reserved.
//

import Foundation

class Observer<T> {
    
    typealias ObserverId = Int
    typealias ObserverValue = T
    typealias ObservableCallback = ((ObserverValue) -> Void)
    
    // an array of all the registered observers
    private var observers: [ObserverId: ObservableCallback] = [:]
    private let lock = NSLock()
    
    private var sequentialId: Int = 0
    
    // the associated value for the observer
    private var value: ObserverValue
    
    init(_ value: ObserverValue) {
        self.value = value
    }
    
    func observe(_ values: @escaping ObservableCallback) -> ObserverId {
        lock.lock()
        defer {
            sequentialId += 1
            lock.unlock()
        }
        
        let id = sequentialId
        observers[id] = values
        
        return id
    }
    
    func getValue() -> ObserverValue {
        return value
    }
    
    
    func removeObserve(with id: ObserverId) {
        observers[id] = nil
    }
    
    func removeObservers() {
        observers.removeAll()
    }
    
    func update(_ value: ObserverValue) {
        self.value = value
        notify()
    }
    
    private func notify() {
        for observer in observers.values {
            observer(value)
        }
    }
}

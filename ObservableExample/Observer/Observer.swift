//
//  Observer.swift
//  ObservableExample
//
//  Created by Andrei Hogea on 01/03/2019.
//  Copyright © 2019 Nodes. All rights reserved.
//

import Foundation

class Observer<ObserverValue> {
    
    typealias ObserverId = Int
    typealias ObservableCallback = ((ObserverValue) -> Void)
    
    // an dictionary of all the registered observers
    private var observers: [ObserverId: ObservableCallback] = [:]
    private let lock = NSLock()
    
    private var sequentialId: Int = 0
    
    // the associated value for the observer
    private var value: ObserverValue
    
    init(_ value: ObserverValue) {
        self.value = value
    }
    
    func observe(_ values: @escaping ObservableCallback) -> Disposable {
        lock.lock()
        defer {
            sequentialId += 1
            lock.unlock()
        }
        
        let id = sequentialId
        observers[id] = values
        values(value)
        
        let disposable = Disposable { [weak self] in
            /// remove observer on deinit
            self?.observers[id] = nil
        }
        
        return disposable
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

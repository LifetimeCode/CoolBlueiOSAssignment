//
//  QueueManager.swift
//  CoolBlue
//
//  Created by Amr Hossam on 1/11/20.
//  Copyright © 2020 Amr Hossam. All rights reserved.
//

import Foundation
import RxSwift

class QueueManager: NSObject {
    static let shared: QueueManager = QueueManager()
    private override init() { }
    
    // running queue for all operation
    private var runningQueue: [String: Any] = [:]
    // get operation by identifer and return @params VFQueueOp if it's already running
    func getOp(_ identifer: String) -> [String: Any]? {
        lock.lock()
        var reqOP: [String: Any]?
        _ = runningQueue.filter({ (operation) -> Bool in
            if operation.key == identifer {
                reqOP = [operation.key: operation.value]
                return true
            }
            return false
        }).first
        lock.unlock()
        return reqOP
    }
    // add new operation by identifere and observable of it
    func addOp<T>(_ identifier: String, _ observable: Observable<T>) {
        lock.lock()
        //check if request already fired
        // create VFQueueOp instance
        runningQueue[identifier] = observable
        lock.unlock()
    }
    private let lock: NSLock = NSLock()
    // remove operation after finish it's task
    func removeOp(_ identifer: String) {
        let removedOp = self.getOp(identifer)
        if removedOp != nil {
            lock.lock()
            runningQueue.removeValue(forKey: identifer)
            lock.unlock()
        }
    }
    /// clear all saved operation
    func clearAll() {
        lock.lock()
        runningQueue = [:]
        lock.unlock()
    }
    
    func getAllOperationsCount() -> Int {
        lock.lock()
        let allOperationsCount = runningQueue.values.count
        lock.unlock()
        return allOperationsCount
    }
    
    func getCurrentOp() -> [String: Any]? {
        lock.lock()
        let current = [runningQueue.keys.first!: runningQueue.values.first!]
        lock.unlock()
        return current
    }
}

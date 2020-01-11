//
//  BaseDispatcher.swift
//  CoolBlue
//
//  Created by Amr Hossam on 7/12/19.
//  Copyright © 2020 Amr Hossam. All rights reserved.
//

import Foundation
import RxSwift

class BaseDispatcher: NSObject {
    static let shared: BaseDispatcher = {
        let shared = BaseDispatcher()
        return shared
    }()
    
    private override init() { }
    
    func getModel<T: Codable>(_ path: String, _ concurrent: Bool = false) -> Observable<Result<T>> {
        if QueueManager.shared.getAllOperationsCount() > 0 && !concurrent {
            let runnningOP = QueueManager.shared.getCurrentOp()
            if let runOp = runnningOP {
                if let runningRequest = (runOp.values.first as? Observable<Result<T>>) {
                    return runningRequest
                }
            }
        }
        let newOP: Observable<Result<T>> = self.getNewModel(path)
        QueueManager.shared.addOp(path, newOP)
        return newOP
    }

    func getNewModel<T: Codable>(_ path: String) -> Observable<Result<T>> {
        return Observable.create { observer in
            var apiDisposable: Disposable?
            apiDisposable = APIClient().executeRequest(path, success: { (item:T) in
                observer.onNext(.response(item))
                QueueManager.shared.removeOp(path)
            }, failure: { (error) in
                observer.onError(BaseError(code: 1))
                QueueManager.shared.removeOp(path)
            })
            return Disposables.create {
                apiDisposable?.dispose()
            }
        }.share()
    }
}

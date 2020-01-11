//
//  DataTask.swift
//  CoolBlue
//
//  Created by Amr Hossam on 1/11/20.
//  Copyright © 2020 Amr Hossam. All rights reserved.
//

import Foundation
import RxSwift

func apiUrl(_ path: String) -> URL {
    return URL(string: "https://bdk0sta2n0.execute-api.eu-west-1.amazonaws.com/ios-assignment/search?\(path)")!
}

enum Result<T: Codable> {
    case response(T)
}

class APIClient: NSObject {
    override init() {
        super.init()
    }
    func executeRequest<T: Codable>(_ path: String,
                                    success: @escaping (_ results: T) -> Void,
                                    failure: @escaping (_ error: String) -> Void ) -> Disposable {
        let requestOb = URLSession.shared.rx.data(request: URLRequest(url: apiUrl(path)))
        return requestOb.mapObject(T.self)
            .subscribe(onNext: { (data) in
                success(data)
            }, onError: { (error) in
                failure(error.localizedDescription)
            })
    }
}

struct BaseError: Error, Codable {
    let code: Int
    // 1 Network fail
    // 2 Parsing fail
    
    init(code: Int) {
        self.code = code
    }
}

extension ObservableType where Element == Data {
    public func mapObject<T: Codable>(_: T.Type) -> Observable<T> {
        return map { jsonData -> T in
            let decoder = JSONDecoder()
            //if let response = String(data: jsonData, encoding: String.Encoding.utf8) {
                //print("RERURNS: \(response)")
            //}
            do {
                let object = try decoder.decode(T.self, from: jsonData)
                return object
            } catch {
                throw BaseError(code: 2)
            }
        }
    }
}

//
//  ProductsListInteractor.swift
//  CoolBlue
//
//  Created by Amr Hossam on 1/11/20.
//  Copyright © 2020 Amr Hossam. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class ProductsListInterator: ProductsListInteractorProtocol {
    var ProductsSubject = PublishRelay<[Product]>()
    var bag = DisposeBag()
    var reachedLast = false
    
    func getData(_ page: Int = 1, _ term: String = "") {
        // New search
        if page == 1 { reachedLast = false }
        // Stop when max pages reached
        guard !reachedLast else { return }
        
        // Get data
        let ProductsOb: Observable<Result<ProductsModel>> = BaseDispatcher.shared.getModel("query=\(term)&page=\(page)")
        ProductsOb.subscribe(onNext: { (result) in
            switch result {
            case .response(let ProductsModel):
                self.ProductsSubject.accept(ProductsModel.products ?? [])
                if (ProductsModel.pageCount ?? 0) == page {
                    self.reachedLast = true
                }
            }
        }, onError: { (error) in
            self.ProductsSubject.accept([])
            showAlert(error.localizedDescription)
        }).disposed(by: bag)
    }
}

//
//  ProductsListViewModel.swift
//  CoolBlue
//
//  Created by Amr Hossam on 1/11/20.
//  Copyright © 2020 Amr Hossam. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class ProductsListViewModel: ProductsListViewModelProtocol {
    internal var interactor: ProductsListInteractorProtocol
    var ProductsSubject = BehaviorRelay(value: [Product]())
    var searchTerm = BehaviorRelay(value: String())
    private var bag = DisposeBag()
    private var page:Int = 1
    
    init(interactor: ProductsListInteractorProtocol) {
        self.interactor = interactor
        configureBinding()
    }
    
    fileprivate func configureBinding() {
        searchTerm.skip(1).distinctUntilChanged()
            .bind { text in
                self.page = 1
                self.ProductsSubject.accept([])
                guard !text.isEmpty else { return }
                self.getData()
        }.disposed(by: bag)
        
        interactor.ProductsSubject
            .observeOn(MainScheduler.asyncInstance)
            .map({ (Products) -> [Product] in
                var newProducts = [Product]()
                for product in Products {
                    if !self.ProductsSubject.value.map({$0.productId}).contains(product.productId) {
                        newProducts.append(product)
                    }
                }
                return newProducts
            })
            .subscribe(onNext: { (Products) in
                if Products.count > 0 { self.page += 1 }
                var currentProducts = self.ProductsSubject.value
                currentProducts.append(contentsOf: Products)
                self.ProductsSubject.accept(currentProducts)
            }).disposed(by: bag)
    }
    
    func getData() {
        interactor.getData(page, searchTerm.value)
    }
}

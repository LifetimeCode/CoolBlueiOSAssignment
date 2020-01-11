//
//  ProductsListAssembly.swift
//  CoolBlue
//
//  Created by Amr Hossam on 1/11/20.
//  Copyright © 2020 Amr Hossam. All rights reserved.
//

import Foundation
import Swinject
import RxSwift
import RxCocoa

class ProductsListAssembler: Assembly {
    func assemble(container: Container) {
        assembleProductsModule(container: container)
        container.storyboardInitCompleted(ProductsListViewController.self) { (resolver, viewController) in
            viewController.initialize(viewModel: resolver.resolve(ProductsListViewModelProtocol.self, name: self.registrationName)!)
        }
    }
    
    private func assembleProductsModule(container: Container) {
        container.register(ProductsListInteractorProtocol.self, name: self.registrationName) { (_) in
            ProductsListInterator()
        }
        container.register(ProductsListViewModelProtocol.self, name: self.registrationName) { (resolver) in
            ProductsListViewModel(interactor: resolver.resolve(ProductsListInteractorProtocol.self, name: self.registrationName)!)
        }
    }
}

protocol ProductsListViewControllerProtocol: class {
    func initialize(viewModel: ProductsListViewModelProtocol)
}

protocol ProductsListViewModelProtocol: BaseViewModelProtocol {
    var interactor: ProductsListInteractorProtocol { get }
    var ProductsSubject: BehaviorRelay<[Product]> { get }
    var searchTerm: BehaviorRelay<String> { get }
    func getData()
}

protocol ProductsListInteractorProtocol: BaseInteractorProtocol {
    var ProductsSubject: PublishRelay<[Product]> { get }
    func getData(_ page: Int, _ term: String)
}

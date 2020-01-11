//
//  CoolBlueTests.swift
//  CoolBlueTests
//
//  Created by Amr Hossam on 1/11/20.
//  Copyright © 2020 Amr Hossam. All rights reserved.
//

import XCTest
import RxSwift
import RxCocoa
import SwinjectStoryboard

@testable import CoolBlue

class CoolBlueTests: XCTestCase {

    var bag: DisposeBag!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        bag = DisposeBag()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAssemblyAndObservables() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.

        let ctrl = SwinjectStoryboard.create(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProductsVC")
        XCTAssertTrue(ctrl.isKind(of: ProductsListViewController.self))
        
        let sut = ctrl as! ProductsListViewController
        XCTAssertNotNil(sut.viewModel)
        XCTAssertNotNil(sut.viewModel.interactor)
        
        XCTAssertNotNil(sut.viewModel.ProductsSubject)
        XCTAssertTrue(sut.viewModel.ProductsSubject.value.isEmpty)
        
        XCTAssertNotNil(sut.viewModel.interactor.ProductsSubject)
        
        let exp1 = expectation(description: "")
        let exp2 = expectation(description: "")

        sut.viewModel.interactor.getData(1, "test")
        sut.viewModel.interactor.ProductsSubject
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { (products) in
                XCTAssertGreaterThan(products.count, 0)
                XCTAssertLessThanOrEqual(products.count, 30)
                exp1.fulfill()
                
                sut.viewModel.ProductsSubject
                    .observeOn(MainScheduler.instance)
                    .subscribe(onNext: { (products) in
                        XCTAssertGreaterThan(products.count, 0)
                        XCTAssertLessThanOrEqual(products.count, 30)
                        exp2.fulfill()
                    }, onError: { (error) in
                        XCTFail("Server failed with error: \(error)")
                        exp2.fulfill()
                    }).disposed(by: self.bag)
                
            }, onError: { (error) in
                XCTFail("Server failed with error: \(error)")
                exp1.fulfill()
            }).disposed(by: bag)


        let result = XCTWaiter().wait(for: [exp1, exp2], timeout: 10, enforceOrder: true)
        if result == .completed {
            //all expectations completed in order
        }
    }

}

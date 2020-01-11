//
//  AppRouter.swift
//  CoolBlue
//
//  Created by Amr Hossam on 7/12/19.
//  Copyright © 2020 Amr Hossam. All rights reserved.
//

import Foundation
import Swinject
import SwinjectStoryboard

class BaseRouter {
    static let shared: BaseRouter = {
        let sharedInstance = BaseRouter()
        return sharedInstance
    }()
    
    var mainNavigation = UINavigationController(rootViewController: SwinjectStoryboard.create(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProductsVC"))
}

class ApplicationAssembly {
    class var assembler: Assembler {
        return Assembler([
            ProductsListAssembler(),
            ])
    }
}

extension SwinjectStoryboard {
    @objc class func setup() {
        defaultContainer = ApplicationAssembly.assembler.resolver as! Container
    }
}

extension Assembly {
    var registrationName: String { return String(describing: Self.self) }
}

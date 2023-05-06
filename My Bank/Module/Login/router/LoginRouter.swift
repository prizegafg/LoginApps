//
//  LoginRouter.swift
//  My Bank
//
//  Created by mac mini ist on 11/04/22.
//

import Foundation
import UIKit

class LoginRouter: PTRLogin {
    // MARK: Login Module
    static func createLoginModule() -> LoginVC {
        let view = LoginVC()
        let presenter = LoginPresenter()
        let interactor: PTILogin = LoginInteractor()
        let router: PTRLogin = LoginRouter()
        
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.presenter = presenter
        view.presenter = presenter
        return view
    }
    
    // MARK: Navigation Function
    func pushToRegister(nav: UINavigationController) {
        let vc = RegisterRouter.createRegisterModule()
        vc.navigationItem.hidesBackButton = true
        nav.pushViewController(vc, animated: false)
    }
    
    func pushToMenu(nav: UINavigationController) {
        let vc = MenuRouter.createMenuModule()
        vc.navigationItem.hidesBackButton = true
        nav.pushViewController(vc, animated: true)
    }
    
    
    
    
    
    
    
}

//
//  RegisterRouter.swift
//  My Bank
//
//  Created by mac mini ist on 11/04/22.
//

import Foundation
import UIKit


class RegisterRouter: PTRRegister {
    
    func pushToLogin(nav: UINavigationController) {
        let vc = LoginRouter.createLoginModule()
        vc.navigationItem.hidesBackButton = true
        nav.pushViewController(vc, animated: true)
    }
    
    func pushToStartMenu(nav: UINavigationController) {
        let vc = StartMenuRouter.createStartMenuModule()
        vc.navigationItem.hidesBackButton = true
        nav.pushViewController(vc, animated: true)
    }
    
    
    static func createRegisterModule() -> RegisterVC {
        let view = RegisterVC()
        let presenter = RegisterPresenter()
        let interactor: PTIRegister = RegisterInteractor()
        let router: PTRRegister = RegisterRouter()
        
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.presenter = presenter
        view.presenter = presenter
        return view
    }
    
}


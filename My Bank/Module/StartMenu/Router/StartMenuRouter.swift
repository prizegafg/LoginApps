//
//  StartMenuRouter.swift
//  My Bank
//
//  Created by Faza Azizi on 10/04/22.
//

import Foundation
import UIKit

class StartMenuRouter: PTRStartMenu{
    func pushToRegister(nav: UINavigationController) {
        let vc = RegisterRouter.createRegisterModule()
        nav.pushViewController(vc, animated: true)
    }
    
    func pushToLogin(nav: UINavigationController){
        let vc = LoginRouter.createLoginModule()
        nav.pushViewController(vc, animated: true)
    }
    
    static func createStartMenuModule() -> StartMenuVC {
        let view = StartMenuVC()
        let presenter = StartMenuPresenter()
        let interactor: PTIStartMenu = StartMenuInteractor()
        let router: PTRStartMenu = StartMenuRouter()
        
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.presenter = presenter
        view.presenter = presenter
        return view
    }
}


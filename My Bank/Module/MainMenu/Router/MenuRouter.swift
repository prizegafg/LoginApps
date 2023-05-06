//
//  MenuRouter.swift
//  My Bank
//
//  Created by mac mini ist on 11/04/22.
//

import Foundation
import UIKit

class MenuRouter: PTRMenu{
    func pushToStartMenu(nav: UINavigationController) {
        let vc = StartMenuRouter.createStartMenuModule()
        vc.navigationItem.hidesBackButton = true
        nav.pushViewController(vc, animated: true)
    }
    
    static func createMenuModule() -> MenuVC {
        let view = MenuVC()
        let presenter = MenuPresenter()
        let interactor: PTIMenu = MenuInteractor()
        let router: PTRMenu = MenuRouter()
        
        
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.presenter = presenter
        view.presenter = presenter
        return view
    }
    
    
    
    
}

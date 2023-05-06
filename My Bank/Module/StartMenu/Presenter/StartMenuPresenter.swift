//
//  StartMenuPresenter.swift
//  My Bank
//
//  Created by Faza Azizi on 10/04/22.
//

import Foundation
import UIKit

class StartMenuPresenter: VTPStartMenu {
    var view: PTVStartMenu?
    
    var interactor: PTIStartMenu?
    
    var router: PTRStartMenu?
    
    func goToLogin(nav: UINavigationController) {
        router?.pushToLogin(nav: nav)
    }
    
    func goToRegister(nav: UINavigationController) {
        router?.pushToRegister(nav: nav)
    }
    
    
}

extension StartMenuPresenter: ITPStartMenu {
    
}

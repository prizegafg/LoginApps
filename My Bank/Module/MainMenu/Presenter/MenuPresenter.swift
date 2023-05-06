//
//  MenuPresenter.swift
//  My Bank
//
//  Created by mac mini ist on 11/04/22.
//

import Foundation
import UIKit

class MenuPresenter: VTPMenu{
    func startLogout(nav: UINavigationController) {
        interactor?.logOut(nav: nav)
    }
    
    
    var view: PTVMenu?
    
    var interactor: PTIMenu?
    
    var router: PTRMenu?
    
    func goToStartMenu(nav: UINavigationController){
        router?.pushToStartMenu(nav: nav)
    }
    
}

extension MenuPresenter: ITPMenu{
    func logOutSucces(nav: UINavigationController) {
        self.goToStartMenu(nav: nav)
    }
    
    func logOutFailed(message: String) {
        view?.showErrorMessage(message: message)
    }
    
    
}

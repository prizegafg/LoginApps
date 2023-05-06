//
//  LoginPresenter.swift
//  My Bank
//
//  Created by mac mini ist on 11/04/22.
//

import Foundation
import UIKit
import LocalAuthentication

class LoginPresenter: VTPLogin {
    var view: PTVLogin?
    var interactor: PTILogin?
    var router: PTRLogin?
    
    // MARK: Login
    func startLogin(nav: UINavigationController, email: String, password: String) {
        interactor?.loginFirebase(nav: nav, email: email, password: password)
    }
    
    
    // MARK: Navigation
    func goToRegister(nav: UINavigationController) {
        router?.pushToRegister(nav: nav)
    }
    func goToMenu(nav: UINavigationController){
        router?.pushToMenu(nav: nav)
    }
    
    
    
    
}

extension LoginPresenter: ITPLogin {
    func loginFirebaseSucces(nav: UINavigationController) {
        self.goToMenu(nav: nav)
    }
    
    func loginFirebaseFailed(message: String) {
        view?.showErrorMessage(message: message)
    }
    
}

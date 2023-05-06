//
//  RegisterPresenter.swift
//  My Bank
//
//  Created by mac mini ist on 11/04/22.
//

import Foundation
import UIKit

class RegisterPresenter: VTPRegister {

    var view: PTVRegister?
    var interactor: PTIRegister?
    var router: PTRRegister?
    
    
    
    // MARK: Navigation
    func goToLogin(nav: UINavigationController) {
        router?.pushToLogin(nav: nav)
    }
    
    func goToStartMenu(nav: UINavigationController){
        router?.pushToStartMenu(nav: nav)
    }
    // MARK: Firebase Setup
    func startFirebase(firstName: String, lastName: String, email: String, password: String, nav: UINavigationController) {
        interactor?.regisFirebase(firstName: firstName, lastName: lastName, email: email, password: password, nav: nav)
    }
}



// MARK: Firebase
extension RegisterPresenter: ITPRegister {
    func regisFirebaseSuccess(nav: UINavigationController, info: String) {
        self.goToStartMenu(nav: nav)
        view?.showSucess(message: info)
    }
    
    
    
    func regisFirebaseFailed(message: String) {
        view?.showError(message: message)
    }
    
    
    
}


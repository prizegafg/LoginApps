//
//  LoginProtocol.swift
//  My Bank
//
//  Created by mac mini ist on 11/04/22.
//

import Foundation
import UIKit
import LocalAuthentication

protocol PTVLogin: AnyObject {
    func showErrorMessage(message: String)
}

protocol VTPLogin: AnyObject {
    var view: PTVLogin? {get set}
    var interactor: PTILogin? {get set}
    var router: PTRLogin? {get set}
    
    func goToRegister(nav: UINavigationController)
    func goToMenu(nav: UINavigationController)
    func startLogin(nav: UINavigationController, email: String, password: String)
    
}

protocol ITPLogin: AnyObject {
    func loginFirebaseSucces(nav: UINavigationController)
    func loginFirebaseFailed(message: String)
}

protocol PTILogin: AnyObject {
    var presenter: ITPLogin? {get set}
    func loginFirebase(nav: UINavigationController, email: String, password: String)
}

protocol PTRLogin: AnyObject {
    static func createLoginModule() -> LoginVC
    func pushToMenu(nav: UINavigationController)
    func pushToRegister(nav: UINavigationController)
}

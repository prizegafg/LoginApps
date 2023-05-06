//
//  StartMenuProtocol.swift
//  My Bank
//
//  Created by Faza Azizi on 10/04/22.
//

import Foundation
import UIKit

protocol PTVStartMenu: AnyObject {
    
}

protocol ITPStartMenu: AnyObject {
    
}

protocol PTIStartMenu: AnyObject {
    var presenter: ITPStartMenu? {get set}
    
}

protocol VTPStartMenu: AnyObject {
    var view: PTVStartMenu? {get set}
    var interactor: PTIStartMenu? {get set}
    var router: PTRStartMenu? {get set}
    
    func goToLogin(nav: UINavigationController)
    func goToRegister(nav: UINavigationController)
}

protocol PTRStartMenu: AnyObject {
    static func createStartMenuModule() -> StartMenuVC
    func pushToLogin(nav: UINavigationController)
    func pushToRegister(nav: UINavigationController)
    
}


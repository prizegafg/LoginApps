//
//  MainMenuProtocol.swift
//  My Bank
//
//  Created by mac mini ist on 11/04/22.
//

import Foundation
import UIKit

protocol PTVMenu: AnyObject{
    func showErrorMessage(message: String)
}

protocol VTPMenu: AnyObject{
    var view: PTVMenu? {get set}
    var interactor: PTIMenu? {get set}
    var router: PTRMenu? {get set}
    
    func startLogout(nav: UINavigationController)
}

protocol ITPMenu: AnyObject{
    func logOutSucces(nav: UINavigationController)
    func logOutFailed(message: String)
}

protocol PTIMenu: AnyObject{
    var presenter: ITPMenu? {get set}
    
    func logOut(nav: UINavigationController)
    
}

protocol PTRMenu: AnyObject{
    static func createMenuModule() -> MenuVC
    func pushToStartMenu(nav: UINavigationController)
}

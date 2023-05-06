//
//  MenuInteractor.swift
//  My Bank
//
//  Created by mac mini ist on 11/04/22.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth

class MenuInteractor: PTIMenu{
    
    var presenter: ITPMenu?
    
    func logOut(nav: UINavigationController) {
        do {
            try Auth.auth().signOut()
            self.presenter?.logOutSucces(nav: nav)
        } catch  {
            self.presenter?.logOutFailed(message: "Error when Log out")
        }
    }
    
}

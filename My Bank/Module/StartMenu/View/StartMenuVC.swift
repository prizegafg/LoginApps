//
//  StartMenuVC.swift
//  My Bank
//
//  Created by Faza Azizi on 10/04/22.
//

import UIKit

// MARK: Set Up Button
class StartMenuVC: UIViewController {

    @IBOutlet weak var btnRegister: UIButton!
    @IBOutlet weak var btnLogin: UIButton!
    
    var presenter: VTPStartMenu?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       

        // Do any additional setup after loading the view.
    }
    @IBAction func pushToRegister(_ sender: Any) {
        presenter?.goToRegister(nav: self.navigationController!)
    }
    @IBAction func pushToLogin(_ sender: Any) {
        presenter?.goToLogin(nav: self.navigationController!)
    }
    


}


// MARK: Presenter to View
extension StartMenuVC: PTVStartMenu{
    
}

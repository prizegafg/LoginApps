//
//  MenuVC.swift
//  My Bank
//
//  Created by mac mini ist on 11/04/22.
//

import UIKit

class MenuVC: UIViewController {

    @IBOutlet weak var btnSignOut: UIButton!
    
    var presenter: VTPMenu?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func onClickSignOut(_ sender: Any) {
        presenter?.startLogout(nav: self.navigationController!)
    }
    func showAlert(message: String){
        let alert = UIAlertController(title: "Failed logout", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
}

extension MenuVC: PTVMenu{
    func showErrorMessage(message: String) {
        showAlert(message: message)
    }
    
    
}

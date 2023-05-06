//
//  RegisterVC.swift
//  My Bank
//
//  Created by mac mini ist on 11/04/22.
//

import UIKit

class RegisterVC: UIViewController {
    

    @IBOutlet weak var txtFirstName: UITextField!
    @IBOutlet weak var txtLastName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtRepeatPassword: UITextField!
    @IBOutlet weak var btnRegister: UIButton!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnHideUnhidePass: UIButton!
    @IBOutlet weak var imgHideUnhidePass: UIImageView!
    @IBOutlet weak var btnHideUnhideRePass: UIButton!
    @IBOutlet weak var imgHideUnhideRePass: UIImageView!
    
    var presenter: VTPRegister?
    var hidePass: Bool = true
    var hideRePass: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setUpAction()
    }
    
    func setUpView(){
        txtFirstName.placeholder = "First Name"
        txtLastName.placeholder = "Last Name"
        txtEmail.placeholder = "Email"
        txtPassword.placeholder = "Password"
        txtRepeatPassword.placeholder = "Repeat Password"
        btnLogin.setTitle("Login", for: .normal)
        btnRegister.setTitle("Register", for: .normal)
        
        btnHideUnhidePass.setTitle("", for: .normal)
        btnHideUnhideRePass.setTitle("", for: .normal)
        imgHideUnhidePass.image = UIImage(named: "Unchecked")
        imgHideUnhideRePass.image = UIImage(named: "Unchecked")
        
        self.navigationItem.setHidesBackButton(true, animated: false)
    }
    
    func setUpAction(){
        btnRegister.addTarget(self, action: #selector(onTapRegister), for: .touchUpInside)
        btnLogin.addTarget(self, action: #selector(onTapLogin), for: .touchUpInside)
        btnHideUnhidePass.addTarget(self, action: #selector(onTapPassword), for: .touchUpInside)
        btnHideUnhideRePass.addTarget(self, action: #selector(onTapRePassword), for: .touchUpInside)
    }
    
    @objc func onTapRegister(_ sender: Any) {
        let error = validateFields()
        
        let firstName = txtFirstName.text?.trim(.whitespacesAndNewlines)
        let lastName = txtLastName.text?.trim(.whitespacesAndNewlines)
        let email = txtEmail.text?.trim(.whitespacesAndNewlines)
        let password = txtPassword.text?.trim(.whitespacesAndNewlines)
        _ = txtRepeatPassword.text?.trim(.whitespacesAndNewlines)
        
        if error != nil{
            PopupAlert.shared.showAlert(title: "Error", message: error!, btnTitle: "Ok")
        }else{
            presenter?.startFirebase(firstName: firstName!, lastName: lastName!, email: email!, password: password!, nav: self.navigationController!)
        }
    }
    
    @objc func onTapLogin(_ sender: Any) {
        presenter?.goToLogin(nav: self.navigationController!)
    }
    
    @objc func onTapPassword(){
        if hidePass == true {
            txtPassword.isSecureTextEntry = false
            imgHideUnhidePass.image = UIImage(named: "Checked")
            hidePass = false
        } else if hidePass == false {
            txtPassword.isSecureTextEntry = true
            imgHideUnhidePass.image = UIImage(named: "Unchecked")
            hidePass = true
        }
    }
    
    @objc func onTapRePassword(){
        if hideRePass == true {
            txtRepeatPassword.isSecureTextEntry = false
            imgHideUnhideRePass.image = UIImage(named: "Checked")
            hideRePass = false
        } else if hideRePass == false {
            txtRepeatPassword.isSecureTextEntry = true
            imgHideUnhideRePass.image = UIImage(named: "Unchecked")
            hideRePass = true
        }
    }
    
    
    public func validatePassword(_ password: String) -> Bool{
        let passwordValidation = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[a-zA-Z\\d]{8,}$")
        return passwordValidation.evaluate(with: password)
    }
    
    func validateFields() -> String?{
        var message = ""
        if txtFirstName.text?.trim(.whitespacesAndNewlines) == "" || txtLastName.text?.trim(.whitespacesAndNewlines) == "" || txtEmail.text?.trim(.whitespacesAndNewlines) == "" || txtPassword.text?.trim(.whitespacesAndNewlines) == "" {
            message = "Please Fill Empty Field First"
        }
        
        let validPassword = txtPassword.text!.trim(.whitespacesAndNewlines)
        
        if validatePassword(validPassword) == false{
            message = "Password must contain at least 8 character, including UPPER, lowercase and numbers"
        }
        
        if txtRepeatPassword.text!.trim(.whitespacesAndNewlines) != txtPassword.text!.trim(.whitespacesAndNewlines) {
            message =  "Password did not match"
            
        }
        
        
        return message
        PopupAlert.shared.showAlertWithoutTitle(message: message, btnTitle: "OK")
    }

}



extension RegisterVC: PTVRegister {
    
    func showSucess(message: String) {
        PopupAlert.shared.showAlert(title: "Success", message: message, btnTitle: "OK")
    }
    
    func showError(message: String) {
        PopupAlert.shared.showAlert(title: "Error", message: message, btnTitle: "OK")
    }
    
}


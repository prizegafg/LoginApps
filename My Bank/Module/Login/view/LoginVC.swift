//
//  LoginVC.swift
//  My Bank
//
//  Created by mac mini ist on 11/04/22.
//

import UIKit
import LocalAuthentication
import FirebaseAuth
import CoreData



// MARK: SetUp Botton
class LoginVC: UIViewController {
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnRegister: UIButton!
    @IBOutlet weak var imgBiometric: UIImageView!
    @IBOutlet weak var btnBiometric: UIButton!
    @IBOutlet weak var btnHideUnhide: UIButton!
    @IBOutlet weak var imgHideUnhide: UIImageView!
    
    
    var email,password: String?
    var presenter: VTPLogin?
    var hideUnhide: Bool? = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setUpAction()
    }
    
    func setUpView(){
        lblTitle.text = "Login"
        btnRegister.setTitle("Register", for: .normal)
        btnLogin.setTitle("Login", for: .normal)
        btnBiometric.setTitle("", for: .normal)
        btnHideUnhide.setTitle("", for: .normal)
        imgBiometric.image = UIImage(named: "Biometric")
        imgHideUnhide.image = UIImage(named: "Unchecked")
    }
    
    func setUpAction(){
        btnLogin.addTarget(self, action: #selector(OnClickLogin), for: .touchUpInside)
        btnRegister.addTarget(self, action: #selector(OnClicRegister), for: .touchUpInside)
        btnBiometric.addTarget(self, action: #selector(OnClickBiometric), for: .touchUpInside)
        btnHideUnhide.addTarget(self, action: #selector(OnClickHideUnhide), for: .touchUpInside)
    }
    
    @objc func OnClickLogin(_ sender: Any){
        let error = validateFields()
        email = txtEmail.text?.trim(.whitespacesAndNewlines)
        password = txtPassword.text?.trim(.whitespacesAndNewlines)
        
        if error != nil{
            PopupAlert.shared.showAlert(title: "Error", message: error!, btnTitle: "OK")
        }else{
            deleteLoginData()
            presenter?.startLogin(nav: self.navigationController!, email: email!, password: password!)
        }
    }
    
    @objc func OnClicRegister(_ sender: Any){
        presenter?.goToRegister(nav: self.navigationController!)
    }
    
    @objc func OnClickBiometric(_ sender: Any){
        biometricSetup()
    }
    
    @objc func OnClickHideUnhide(){
        if hideUnhide == true {
            imgHideUnhide.image = UIImage(named: "Checked")
            txtPassword.isSecureTextEntry = false
            hideUnhide = false
        } else if hideUnhide == false {
            imgHideUnhide.image = UIImage(named: "Unchecked")
            txtPassword.isSecureTextEntry = true
            hideUnhide = true
        }
        
    }
    
    
    
    
}

extension LoginVC {
    // MARK: Validation Login
    func validateFields() -> String?{
        var message = ""
        if email == "" || password == "" {
            message = "Please Fill Empety Field"
        }
        return message
    }
    
    // MARK: Biometric SetUp
    func biometricSetup(){
        let context = LAContext()
        var error: NSError?
        
        guard context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) else {
            PopupAlert.shared.showAlert(title: "Error", message: "Biometric authentication not available or has not been set up.", btnTitle: "OK")
            return
        }
        
        let reason = "Authenticate with Biometrics"
        context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { [weak self] success, authenticationError in
            DispatchQueue.main.async {
                
                if success {
                    // Authentication succeeded
                    self!.fetchLoginData()
                } else {
                    // Authentication failed
                    guard let error = authenticationError as? LAError else { return }
                    var message = "Biometric authentication failed."
//                    switch error {
//                    case .authenticationFailed:
//                        message = "Biometric authentication failed."
//                    case .userCancel:
//                        message = "Biometric authentication was canceled by the user."
//                    case .userFallback:
//                        message = "User tapped the fallback button (Enter Password)."
//                    case .systemCancel:
//                        message = "Biometric authentication was canceled by system."
//                    case .passcodeNotSet:
//                        message = "Passcode is not set on the device."
//                    case .biometryNotAvailable:
//                        message = "Biometric authentication is not available on the device."
//                    case .biometryNotEnrolled:
//                        message = "Biometric authentication is not enrolled on the device."
//                    case .biometryLockout:
//                        message = "Biometric authentication is locked due to too many failed attempts."
//                    default:
//                        message = "Unknown error occurred during biometric authentication."
//                    }
                    PopupAlert.shared.showAlert(title: "Error", message: message, btnTitle: "OK")
                }
            }
        }
    }
    
    func saveLoginData(){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

        // Create a new User object
        let user = User(context: context)
        user.email = txtEmail.text
        user.password = txtPassword.text

        // Save the context
        do {
            try context.save()
        } catch let error as NSError {
            PopupAlert.shared.showAlert(title: "Error", message: "Error Save Data", btnTitle: "OK")
        }
    }
    
    func fetchLoginData(){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

        // Fetch the User objects
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.fetchLimit = 1
        do {
            let results = try context.fetch(fetchRequest)
            if let firstResult = results.first {
                txtEmail.text = firstResult.email
                txtPassword.text = firstResult.password
                let logEmail = txtEmail.text?.trim(.whitespacesAndNewlines)
                let logPassword = txtPassword.text?.trim(.whitespacesAndNewlines)
                if let nav = navigationController {
                    presenter?.startLogin(nav: nav, email: logEmail!, password: logPassword!)
                }
                
            } else {
                PopupAlert.shared.showAlert(title: "Error", message: "No Data Retrived", btnTitle: "OK")
            }
        } catch let error as NSError {
            PopupAlert.shared.showAlert(title: "Error", message: "Could Not Fetch", btnTitle: "OK")
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    func deleteLoginData(){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        do {
            let users = try context.fetch(fetchRequest)
            for user in users {
                context.delete(user)
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        saveLoginData()
    }
    
}

extension LoginVC: PTVLogin{
    func showErrorMessage(message: String) {
        PopupAlert.shared.showAlert(title: "Error", message: message, btnTitle: "OK")
    }
    
}




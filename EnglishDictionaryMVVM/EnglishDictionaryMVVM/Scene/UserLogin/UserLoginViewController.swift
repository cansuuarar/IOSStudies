//
//  UserLoginViewController.swift
//  EnglishDictionaryMVVM
//
//  Created by CANSU ARAR on 16.12.2024.
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

final class UserLoginViewController: UIViewController {
    
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!

    @IBAction private func loginbuttonPressed(_ sender: Any) {
        
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().signIn(withEmail: email, password: password) {  authResult, error in
                if let e = error {
                    let alertController = UIAlertController(title: "Warning",
                                                            message: "\(String(describing: e.localizedDescription))",
                                                            preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in }))
                    self.present(alertController, animated: true, completion: nil)
                }
                else {
                    guard let searchVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "searchVC") as? WordSearchViewController else { return }
                    self.navigationController?.pushViewController(searchVC, animated: true)
                }
            }
        }
        
        emailTextField.text = ""
        passwordTextField.text = ""

        
    }
}

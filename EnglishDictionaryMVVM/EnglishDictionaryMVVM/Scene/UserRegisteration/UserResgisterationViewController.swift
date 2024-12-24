//
//  UserResgisterationViewController.swift
//  EnglishDictionaryMVVM
//
//  Created by CANSU ARAR on 16.12.2024.
//

import UIKit
import FirebaseAuth
import FirebaseAnalytics

final class UserResgisterationViewController: UIViewController {

    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
          AnalyticsParameterItemID: "id-\(title!)",
          AnalyticsParameterItemName: title!,
          AnalyticsParameterContentType: "cont",
        ])

    }
    
    @IBAction private func registerButtonPressed(_ sender: Any) {
        if let email = emailTextField.text, let password = passwordTextField.text {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    let alertController = UIAlertController(title: "Warning",
                                                            message: "\(String(describing: e.localizedDescription))",
                                                            preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in }))
                    self.present(alertController, animated: true, completion: nil)
          
                } else {
                    guard let searchVC = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "searchVC") as? WordSearchViewController else { return }
                    self.navigationController?.pushViewController(searchVC, animated: true)
                }
               
            }
        }
    }
}

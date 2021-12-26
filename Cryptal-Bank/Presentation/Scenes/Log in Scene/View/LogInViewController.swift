//
//  LogInViewController.swift
//  Cryptal-Bank
//
//  Created by MacBook Pro on 16.12.21.
//

import UIKit
import FirebaseAuth

class LogInViewController: UIViewController {
  
   
    @IBOutlet weak var bEmailFild: FloatingLabelInput!
    @IBOutlet weak var bPasswordFild: FloatingLabelInput!
   

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.isNavigationBarHidden = false
    }
    
    @IBAction func onLoginButtonClick(_ sender: Any) {
        
      
        
        
        guard
            let email = bEmailFild.text,
            let password = bPasswordFild.text,
            !email.isEmpty,
            !password.isEmpty
        else { return }
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] user, error in
            if let error = error, user == nil {
                let alert = UIAlertController(
                    title: "Sign In Failed",
                    message: error.localizedDescription,
                    preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .default))
                self?.present(alert, animated: true, completion: nil)
            }else {
                UDManager.markUserAsLoggedIn()
                
                self?.navigationController?.popToRootViewController( animated: false )
                let sb = UIStoryboard(name: "MainDashboardTabBarController", bundle: nil)
                let vc = sb.instantiateViewController(withIdentifier: "MainDashboardTabBarController")
                
                self?.navigationController?.viewControllers.removeAll()
                vc.modalPresentationStyle = .fullScreen
                self?.present(vc, animated: true)
                
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
}

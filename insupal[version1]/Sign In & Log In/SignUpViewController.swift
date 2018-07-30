//
//  SignUpViewController.swift
//  insupal[version1]
//
//  Created by Nicole on 2018-07-16.
//  Copyright © 2018 cherrycat. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SignUpViewController: UIViewController {
    
    // Outlets
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var responseMessage: UILabel!
    
    // Sign Up button
    @IBAction func signUpButton(_ sender: UIButton) {
        handleSignUp()
    }
    
    // to hide the keyboard on touch
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // to load firebase into the application
        if FirebaseApp.app() == nil {
            FirebaseApp.configure()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // to trigger the sign up
    func handleSignUp() {
        guard let username = usernameText.text else {return}
        guard let email = emailField.text else {return}
        guard let pass = passwordField.text else {return}
        
        Auth.auth().createUser(withEmail: email, password: pass) { user, error in
            if error == nil && user != nil {
                print("User created!")
                
                let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                changeRequest?.displayName = username
                changeRequest?.commitChanges {error in
                    if error == nil {
                        print("User display name changed!")
                        self.responseMessage.text = "New Account was Created!"
                    }
                }
            } else {
                print("\(error!.localizedDescription)")
            }
        }
        
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}


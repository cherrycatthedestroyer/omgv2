//
//  LogInViewController.swift
//  insupal[version1]
//
//  Created by Nicole on 2018-07-16.
//  Copyright © 2018 cherrycat. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class LogInViewController: UIViewController {
    
    // Outlets
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var errorMessage: UILabel!
    
    // Actions
    @IBAction func logInButton(_ sender: UIButton) {
        handleSignIn()
        let user = Auth.auth().currentUser
        if ((user) != nil) {
            performSegue(withIdentifier: "Home", sender: self)
        } else {
            // no user is signed in
        }
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
    
    // to trigger the sign in
    func handleSignIn() {
        guard let email = emailField.text else {return}
        guard let pass = passwordField.text else {return}
        
        Auth.auth().signIn(withEmail: email, password: pass) {user, error in
            if error == nil && user != nil {
                print("Successfully logged in!")
            } else {
                self.errorMessage.text = "Error logging in: \(error!.localizedDescription)"
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


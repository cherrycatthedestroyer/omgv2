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
    
    // Actions - when the login button is pressed
    @IBAction func logInButton(_ sender: UIButton) {
        handleSignIn()
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
    
    // to trigger the sign in
    func handleSignIn() {
        guard let email = emailField.text else {return}
        guard let pass = passwordField.text else {return}
        
        // authenticate log in information
        Auth.auth().signIn(withEmail: email, password: pass) {user, error in
            if error == nil && user != nil {
                print("Successfully logged in!")
                // switches the view controller on a successful log in
                let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Home") as UIViewController
                self.present(viewController, animated: false, completion: nil)
            } else {
                // prints an error message if the log in was not successful
                self.errorMessage.text = "\(error!.localizedDescription)"
                print("Error logging in: \(error!.localizedDescription)")
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


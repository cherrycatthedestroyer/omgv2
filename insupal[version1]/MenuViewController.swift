//
//  MenuViewController.swift
//  insupal[version1]
//
//  Created by cherrycat on 2018-07-29.
//  Copyright © 2018 cherrycat. All rights reserved.
//

import UIKit
import FirebaseAuth

class MenuViewController: UIViewController{
    
    // to handle user sign out
    @IBAction func handleSignOut(_ sender: UIButton) {
        do {
            try Auth.auth().signOut()
            let viewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginScreen") as UIViewController
            self.present(viewController, animated: true, completion: nil)
            print("Successfully logged out")
        } catch let err {
            print(err)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

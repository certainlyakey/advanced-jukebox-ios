//
//  LoginViewController.swift
//  adv-jukebox
//
//  Created by Ondrej on 04/05/16.
//  Copyright © 2016 AleksandrBeliaev. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var PasswordTextField: UITextField!

    @IBAction func StartTypingPassword(sender: AnyObject) {
        PasswordTextField.secureTextEntry = true
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
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

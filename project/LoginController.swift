//
//  LoginController.swift
//  project
//
//  Created by Duong Elizabeth on 11/30/18.
//  Copyright © 2018 De La Rosa Rivero Francisco. All rights reserved.
//

import UIKit
import Firebase

class LoginContoller: UIViewController {
    
    let myFileURL = Bundle.main.path(forResource: "myAccount", ofType: "txt")
    

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let accountView = UIImageView();
        let lockView = UIImageView();
        let account = UIImage(named: "account.png");
        let lock = UIImage(named: "lock.png");
        accountView.image = account;
        lockView.image = lock;
        email.leftView = accountView;
        email.leftViewMode = UITextFieldViewMode.always
        email.leftViewMode = .always
        password.leftView = lockView;
        password.leftViewMode = UITextFieldViewMode.always
        password.leftViewMode = .always
        accountView.frame = CGRect(x: 5, y: 0, width: email.frame.height - 5, height: email.frame.height - 5); view.addSubview(accountView)
        lockView.frame = CGRect(x: 5, y: 0, width: password.frame.height - 5 , height: password.frame.height - 5); view.addSubview(lockView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func onLoginClicked(_ sender: UIButton) {
        Auth.auth().signIn(withEmail: email.text!, password: password.text!) { (user, error) in
            if error == nil{
                self.performSegue(withIdentifier: "loginToAccount", sender: self)
            }
            else{
                let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        let accountVC = segue.destinationViewController as RegistrationController
        destinationVC.email = self.email.text
    }
}

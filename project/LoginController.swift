//
//  LoginController.swift
//  project
//
//  Created by Duong Elizabeth on 11/30/18.
//  Copyright © 2018 De La Rosa Rivero Francisco. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class LoginContoller: UIViewController {
    
    let myFileURL = Bundle.main.path(forResource: "myAccount", ofType: "txt")
    var userUid: String = "";

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
        Auth.auth().signIn(withEmail: email.text!, password: password.text!) { (authResult, error) in
            if error == nil{
                guard let user = authResult?.user else { return }
                self.userUid = user.uid
                let ref = Database.database().reference()
                ref.child("users").child(user.uid).observeSingleEvent(of: .value, with: { (snapshot) in
                    // Get user value
                    let value = snapshot.value as? NSDictionary
                    let accountType = value?["type"] as? String ?? ""
                    if accountType == "Doctor" {
                        self.performSegue(withIdentifier: "loginToDoctorView", sender: self)
                    } else if accountType == "Patient" {
                        self.performSegue(withIdentifier: "loginToPatientView", sender: self)
                    } else if accountType == "Pharmacy" {
                        self.performSegue(withIdentifier: "loginToPharmacyView", sender: self)
                    } else {
                        self.performSegue(withIdentifier: "loginToAccount", sender: self)
                    }
                   
                }) { (error) in
                    print(error.localizedDescription)
                }
            }
            else{
                let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                
                alertController.addAction(defaultAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            switch identifier {
            case "loginToAccount":
                let accountVC = segue.destination as! AccountController
                accountVC.userUid = self.userUid
            default: break
            }
        }
        
    }
}

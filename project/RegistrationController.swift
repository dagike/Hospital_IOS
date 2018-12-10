//
//  RegistrationController.swift
//  project
//
//  Created by Duong Elizabeth on 11/30/18.
//  Copyright © 2018 De La Rosa Rivero Francisco. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class RegistrationController: UIViewController
    {
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    var userUid: String = "";
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //        textField_firstName.attributedPlaceholder =
        //            NSAttributedString(string: "First Name", attributes: [NSAttributedStringKey.foregroundColor:])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func registerAction(_ sender: Any) {
        if password.text != confirmPassword.text {
            let alertController = UIAlertController(title: "Password Incorrect", message: "Please re-type password", preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        }
        else{
            let ref = Database.database().reference()
            Auth.auth().createUser(
                withEmail: email.text!,
                password: password.text!,
                completion: { (authResult, error) in
                    guard let user = authResult?.user else { return }
                    if error == nil {
                        let values = ["firstName": self.firstName.text!, "lastName": self.lastName.text!, "userName": self.userName.text!, "email": self.email.text!]
                        ref.child("users").child(user.uid).setValue(values)
                        self.userUid = user.uid
                        self.performSegue(withIdentifier: "registerToAccount", sender: self)
                    }
                    else{
                        let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                        let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                        
                        alertController.addAction(defaultAction)
                        self.present(alertController, animated: true, completion: nil)
                    }
            }
            )
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let accountVC = segue.destination as! AccountController
        accountVC.userUid = self.userUid
    }
}

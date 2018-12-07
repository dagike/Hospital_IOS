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
//                        ref.child("data/users").updateChildValues(["\(Auth.auth().currentUser!.uid)":["Username":self.username.text!]])

                        ref.child("data/users").child(user.uid).setValue(self.email.text!)
                        //                    let firstNameData = ["firstName": self.firstName.text] as [String : Any]
                        //                    let lastNameData = ["lastName": self.lastName.text] as [String : Any]
                        //                    let userNameData = ["userName": self.userName.text] as [String : Any]
                        //                    ref.child(user.uid).updateChildValues(firstNameData)
                        //                    ref.child(user.uid).updateChildValues(lastNameData)
                        //                    ref.child(user.uid).updateChildValues(userNameData)
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        let accountVC = segue.destinationViewController as RegistrationController
        destinationVC.email = self.email.text
    }
}

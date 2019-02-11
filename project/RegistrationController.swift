//
//  RegistrationController.swift
//  project
//
//  Created by Duong Elizabeth on 11/30/18.
//  Copyright © 2018 De La Rosa Rivero Francisco. All rights reserved.
//

import UIKit
import Foundation
import Firebase
import FirebaseDatabase
import FirebaseAuth

class RegistrationController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate
{
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    @IBOutlet weak var accountType: UITextField!
    var userUid: String = "";
    let types = ["Patient", "Administrator", "Doctor", "Pharmacy"]
    let pickerView = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = self
        
        accountType.inputView = pickerView
        // Do any additional setup after loading the view, typically from a nib.
        
        //        textField_firstName.attributedPlaceholder =
        //            NSAttributedString(string: "First Name", attributes: [NSAttributedStringKey.foregroundColor:])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return types.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return types[row]
    }
    
    // When user selects an option, this function will set the text of the text field to reflect
    // the selected option.
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        accountType.text = types[row]
        self.view.endEditing(true)
        
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
                        let values = ["firstName": self.firstName.text!, "lastName": self.lastName.text!, "userName": self.userName.text!, "email": self.email.text!, "type": self.accountType.text!]
                        ref.child("users").child(user.uid).setValue(values)
                        self.userUid = user.uid
                        
                        if(self.accountType.text == "Patient") {
                            self.performSegue(withIdentifier: "registerToPatientView", sender: self)
                        } else if(self.accountType.text == "Doctor") {
                            self.performSegue(withIdentifier: "registerToDoctorView", sender: self)
                        } else if(self.accountType.text == "Pharmacy") {
                            self.performSegue(withIdentifier: "registerToPharmacyView", sender: self)
                        } else {
                            self.performSegue(withIdentifier: "registerToAccount", sender: self)
                        }
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
//        let accountVC = segue.destination as! AccountController
//        accountVC.userUid = self.userUid
        if let identifier = segue.identifier {
            switch identifier {
//            case "registerToPatientView":
//                let accountVC = segue.destination as! AccountController
//                accountVC.userUid = self.userUid
                
//            case "registerToDoctorView":
//                let accountVC = segue.destination as! AccountController
//                accountVC.userUid = self.userUid
//            case "registerToPharmacyView":
//                let accountVC = segue.destination as! AccountController
//                accountVC.userUid = self.userUid
            default: break
            }
        }
    }
}

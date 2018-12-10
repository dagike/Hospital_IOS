//
//  AccountController.swift
//  project
//
//  Created by Kachan Oleksii on 11/30/18.
//  Copyright © 2018 De La Rosa Rivero Francisco. All rights reserved.
//


import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class AccountController: UIViewController {
    @IBOutlet weak var label_userInitials: UILabel!
    @IBOutlet weak var label_userFullname: UILabel!
    @IBOutlet weak var label_login: UILabel!
    @IBOutlet weak var label_email: UILabel!
    
    var userModel: UserModel?
    var userUid: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        // TODO: load from db by email
        let ref = Database.database().reference()
        ref.child("users").child((self.userUid)!).observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            let firstName = value?["firstName"] as? String ?? ""
            let lastName = value?["lastName"] as? String ?? ""
            let userName = value?["userName"] as? String ?? ""
            let email = value?["email"] as? String ?? ""
            
            self.userModel = UserModel(firstName: firstName, lastName: lastName, login: userName, email: email)

            self.label_userInitials.text = self.userModel?.getInitials()
            self.label_userFullname.text = self.userModel?.getFullName()
            self.label_email.text = self.userModel?.email
            self.label_login.text = self.userModel?.login
        }) { (error) in
            print(error.localizedDescription)
        }
        print("userFullName = \(String(describing: self.userModel?.email))")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func action_accountSettings(_ sender: UIButton) {
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 175, y: self.view.frame.size.height-100, width: 350, height: 80))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font = UIFont(name: "Montserrat-Light", size: 12.0)
        toastLabel.text = "Account Settings is not implemented yet"
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
    
    @IBAction func action_logout(_ sender: UIButton) {
        do {
            try Auth.auth().signOut()
        }
        catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initial = storyboard.instantiateInitialViewController()
        UIApplication.shared.keyWindow?.rootViewController = initial
    }
}

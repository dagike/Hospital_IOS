//
//  LoginController.swift
//  project
//
//  Created by Duong Elizabeth on 11/30/18.
//  Copyright © 2018 De La Rosa Rivero Francisco. All rights reserved.
//

import UIKit

class LoginContoller: UIViewController {
    
   
    @IBOutlet weak var userName: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    @IBAction func testLogin(_ sender: UIButton) {
        
        password.text = userName.text!
        
    }
}

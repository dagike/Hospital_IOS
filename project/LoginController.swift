//
//  LoginController.swift
//  project
//
//  Created by Duong Elizabeth on 11/30/18.
//  Copyright © 2018 De La Rosa Rivero Francisco. All rights reserved.
//

import UIKit

class LoginContoller: UIViewController {
    
    let myFileURL = Bundle.main.path(forResource: "myAccount", ofType: "txt")
    
    @IBOutlet weak var userName: UITextField!
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
        userName.leftView = accountView;
        userName.leftViewMode = UITextFieldViewMode.always
        userName.leftViewMode = .always
        password.leftView = lockView;
        password.leftViewMode = UITextFieldViewMode.always
        password.leftViewMode = .always
        accountView.frame = CGRect(x: 5, y: 0, width: userName.frame.height - 5, height: userName.frame.height - 5); view.addSubview(accountView)
        lockView.frame = CGRect(x: 5, y: 0, width: password.frame.height - 5 , height: password.frame.height - 5); view.addSubview(lockView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func onLoginClicked(_ sender: UIButton) {
        var getFileContent = ""
        do {
            getFileContent += try String (contentsOfFile: myFileURL!, encoding:String.Encoding.utf8)
        }catch let error as NSError {
            print("Failed due to \(error)")
        }
        
//        userName.text = getFileContent
        
    }
    
    
}

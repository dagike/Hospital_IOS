//
//  ReportingController.swift
//  project
//
//  Created by 김인국 on 2019-01-25.
//  Copyright © 2019 De La Rosa Rivero Francisco. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class ReportingController: UIViewController {
    
    @IBOutlet weak var lbUserCount: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let ref = Database.database().reference()
        ref.child("users").observe(.value, with: { (snapshot) in
            // Get user value
            self.lbUserCount.text = String(snapshot.childrenCount);
        }) { (error) in
            print(error.localizedDescription)
        }
        //print(count);
        //print(users)
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

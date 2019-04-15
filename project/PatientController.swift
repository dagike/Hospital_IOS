//
//  PatientController.swift
//  project
//
//  Created by 김인국 on 2019-02-25.
//  Copyright © 2019 De La Rosa Rivero Francisco. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class PatientController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var txtDatePicker: UITextField!
    @IBOutlet weak var btnBook: UIButton!
    @IBOutlet weak var btnBooking: UIButton!
    @IBOutlet weak var appointmentList: UITableView!
    
    
    var bookings: [String] = []
    let cellReuseIdentifier = "cell"
    var userUid: String?
    let datePicker = UIDatePicker()
    let ref = Database.database().reference()
    
    override func viewDidAppear(_ animated: Bool) {
        
        loadBooking()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        showDatePicker()
        
        self.appointmentList.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        appointmentList.delegate = self
        appointmentList.dataSource = self
        
        
    }
    func loadBooking() {
        self.bookings.removeAll()
        ref.child("books").child((self.userUid)!).observeSingleEvent(of: .value, with: { (snapshot) in
            for child in snapshot.children {
                let snap = child as! DataSnapshot
                let value = snap.value as? NSDictionary
                let date = value?["date"] as? String ?? ""
                self.bookings.append(date)
            }
            print(self.bookings)
            self.appointmentList.reloadData()
            
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.bookings.count
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell:UITableViewCell = self.appointmentList.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as UITableViewCell!
        
        cell.textLabel?.text = self.bookings[indexPath.row]
        
        return cell
    }
    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
    }
    
    // this method handles row deletion
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            // remove the item from the data model
            bookings.remove(at: indexPath.row)
            
            // delete the table view row
            appointmentList.deleteRows(at: [indexPath], with: .fade)
            
            
        } else if editingStyle == .insert {
            // Not used in our example, but if you were adding a new row, this is where you would do it.
        }
    }
    
    @IBAction func bookingAction(_ sender: Any) {
        let ref = Database.database().reference()
        let values = ["userId": self.userUid, "date": self.txtDatePicker.text!, "doctorId": ""]
        ref.child("books").childByAutoId().setValue(values)
        
        txtDatePicker.text = ""
        loadBooking()
    }

    func showDatePicker(){
        //Formate Date
        datePicker.datePickerMode = .date
        
        //ToolBar
        let toolbar = UIToolbar();
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));
        
        toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
        
        txtDatePicker.inputAccessoryView = toolbar
        txtDatePicker.inputView = datePicker
        
    }
    
    @objc func donedatePicker(){
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        txtDatePicker.text = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    @objc func cancelDatePicker(){
        self.view.endEditing(true)
    }
}

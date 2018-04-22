//
//  AddCourseViewController.swift
//  uguide
//
//  Created by Sebastian Frelle Koch on 4/16/18.
//  Copyright © 2018 Sebastian Frelle Koch. All rights reserved.
//

import UIKit
import os.log

class AddCourseViewController: UIViewController, UITextFieldDelegate {
    
    var course: Course?
    
    @IBOutlet weak var courseNameField: UITextField!
    @IBOutlet weak var courseIDField: UITextField!
    @IBOutlet weak var campusField: UITextField!
    @IBOutlet weak var buildingField: UITextField!
    @IBOutlet weak var roomField: UITextField!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBOutlet var courseFields: [UITextField]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for cf in courseFields {
            cf.delegate = self
        }
        	
        saveButton.isEnabled = false
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: .default, type: .debug)
            
            return
        }
        
        let name = courseNameField.text!
        let id = courseIDField.text!
        let campus = Campus(name: campusField.text!)
        let building = Building(name: buildingField.text!)
        let room = Room(name: roomField.text!)
        
//        course = Course(name: name,
//                        id: id)
    }
    
    //MARK: Private methods
    private func updateSaveButtonState() {
        for cf in courseFields {
            let text = cf.text ?? ""
            if text.isEmpty {
                saveButton.isEnabled = false
                return
            }
        }
        
        saveButton.isEnabled = true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        saveButton.isEnabled = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
}

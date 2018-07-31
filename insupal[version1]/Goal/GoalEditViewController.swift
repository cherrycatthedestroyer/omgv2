//  CMPT 276 Project Group 12 - Smart Apps
//  GoalEditViewController.swift
//  
//
//  Created by Stanislaw Kalinowski on 2018-07-03.
//  Copyright © 2018 Stanislaw Kalinowski. All rights reserved.
//
// Class for the Goal Edit Page
// - transfers the users input from the edit page into the table view goal page
//

import UIKit
import os.log


class GoalEditViewController: UIViewController, UITextViewDelegate {

    var theGoal:Goal?
    var alertInt = 0
    
    //Mark: properties
    @IBOutlet weak var goalTextView: UITextView!
    @IBOutlet weak var specificsTextView: UITextView!
    
    @IBOutlet weak var dueDatePicker: UIDatePicker!
    
    //Mrk: Buttons
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet var deleteButton: UIButton!
    
    //Mark: Navigation
    
    // to hide the keyboard on touch
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        goalTextView.delegate = self
        
        specificsTextView.delegate = self
        
        deleteButton.isHidden = true
        
        goalTextView.layer.cornerRadius = 8
        specificsTextView.layer.cornerRadius = 8
        //Setting up edit view with previous data
        
        //make sure theGoal isnt nil
        if let theGoal = theGoal{
            
            deleteButton.isHidden = false
            
            //Setting up date formate for date
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM d, yyyy"
            
            //Entering the data into UI portions
            goalTextView.text = theGoal.getDescription()
            specificsTextView.text = theGoal.getSpecifics()
            dueDatePicker.date = dateFormatter.date(from: theGoal.getDue())!
            
        }
        
        //Enable save button only if user imputted something
        updateSaveButtonState()
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
    //Mark: UITextViewDelegate
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        updateSaveButtonState()
        
    }
    
    private func textViewDidBeginEditing(_ goalTextView: UITextViewDelegate){
          //Disable Save button when editing!
          saveButton.isEnabled = false
    }
    
    
    
    //Mark:Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){

        
        
        super.prepare(for: segue, sender: sender)
        
        // Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIButton, (button === saveButton || button === deleteButton) else {
            os_log("The save or delete button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        //Sets negative alert type for delete
        if(button === deleteButton){
            alertInt = -1
        } else if(button === cancelButton){
            alertInt = 2
        } else {
            //makes alertType non zero for future edits
            alertInt = 1
        }
        
        //Setting up DateFormatter
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
        //Setting up fields for the goals
        let goalDescrip = goalTextView.text ?? ""
        let specificsText = specificsTextView.text ?? ""
        let dueDate = dateFormatter.string(from : dueDatePicker.date)
        
        //Set the goal that is being returned
        theGoal = Goal(goalDescription: goalDescrip, specifics: specificsText, due:dueDate, alertType:alertInt)
    }
    
    
    //Mark: Private Methods
    private func updateSaveButtonState() {
        // Disable the Save button if the text field is empty.
        let text = goalTextView.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
    
}

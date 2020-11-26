//
//  AddPingViewController.swift
//  Ping
//
//  Created by Gokul Nair on 25/11/20.
//

import UIKit

class AddPingViewController: UIViewController {
    
    var note:Note?
    var update = false
    
    //MARK:- OUTLETS
    
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var notesField: UITextView!
    @IBOutlet weak var deleteButton: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // here we are bifurcating the operations(when update is required then only the curent note's data will be shown)
        if update == true {
            titleField.text = note!.title
            notesField.text = note!.note
        }
        
        // Left swipe gesture
        
        let leftswipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(sender:)))
        view.addGestureRecognizer(leftswipe)
        
       // navigationItem.largeTitleDisplayMode = .never
    }
    
    //MARK:- SWIPE GESTURE METHOD
    @objc func handleSwipe(sender: UISwipeGestureRecognizer){
         
           self.navigationController?.popToRootViewController(animated: true)
       }
    
    //MARK:- ADD NOTES BUTTON
    
    @IBAction func addBtn(_ sender: Any) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let currentDate = dateFormatter.string(from: Date())
        
        // checking no fields are empty
        if (titleField.text != "" && notesField.text != "") {
            
            // bifurcating the task based on user's need
            if update == true {
                
                APIFunctions.functions.updateNote(date: currentDate, title: titleField.text!, note: notesField.text!, id: note!._id)
                
            }
            else{
                
                APIFunctions.functions.addNote(date: currentDate, title: titleField.text!, note: notesField.text!)
                
            }
        }
        // showing a pop-up to tell fields are empty
        else{
            
            let alert = UIAlertController(title: "Error!", message: "Fields are empty!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            
        }
        
        self.navigationController?.popToRootViewController(animated: true)
        haptic.hapticTouch.haptiFeedbackSucess()
    }
    
    // UPDATING VIEWS
    
    override func viewWillAppear(_ animated: Bool) {
        // removing the update button if the task is to add a new note
        if update == false {
            deleteButton.isEnabled = false
            deleteButton.title = ""
        }
        
    }
    
    //MARK:- DELETE BUTTON
    
    @IBAction func deleteBtn(_ sender: Any) {
        
        APIFunctions.functions.deleteNote(id: note!._id)
        self.navigationController?.popToRootViewController(animated: true)
        haptic.hapticTouch.haptiFeedbackSucess()
    }
    
    // Keyboard dismisal function
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)

    }
    
}

//
//  ViewController.swift
//  Ping
//
//  Created by Gokul Nair on 25/11/20.
//

import UIKit

//MARK:- PROTOCOL & DELEGATE

protocol DataDelegate{
    func updateArray(newArray: String)
}

class MainViewController: UIViewController {
    
    var NotesArray = [Note]()
    
    @IBOutlet weak var pingTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // to call the protocol to perform task
        APIFunctions.functions.delegate = self
        APIFunctions.functions.fetchNotes()
       // UINavigationBar.appearance().barTintColor = .black
        
        //MARK:- Onboarding Stuffs
        
        if core.shared.isNewUser() {
            let vc = storyboard?.instantiateViewController(identifier: "onboarding") as! onboardingViewController
            present(vc, animated: true)
        }
    }
    
    //MARK:-  Add button action
    
    @IBAction func addNotesBtn(_ sender: Any) {
        haptic.hapticTouch.haptiFeedbackSucess()
    }
    
    // UPDATING THE VIEW
    
    override func viewWillAppear(_ animated: Bool) {
        APIFunctions.functions.fetchNotes()
        //navigationController?.navigationBar.prefersLargeTitles = true

    }
    
    // UPDATING THE VIEW
    
    override func viewDidAppear(_ animated: Bool) {
        APIFunctions.functions.fetchNotes()
       // navigationController?.navigationBar.prefersLargeTitles = true

    }
}

//MARK:- TABLEVIEW FUNCTIONS

extension MainViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NotesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PingTableViewCell
        // cell customisations
        cell.titleLabel.text = self.NotesArray[indexPath.row].title
        cell.pingLabel.text = self.NotesArray[indexPath.row].note
        cell.dateLabel.text =  self.NotesArray[indexPath.row].date
        // cell.selectionStyle = .none
        
        cell.layer.cornerRadius = 10
        cell.layer.borderWidth = 0.5
        cell.layer.borderColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
  
    // PASSING VALUE TO ANOTHER VIEW CONTROLLER
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! AddPingViewController
        
        if segue.identifier == "cellValue" {
            vc.note = NotesArray[pingTableView.indexPathForSelectedRow!.row]
            vc.update = true
        }
    }
    
    
}

//MARK:-  CUSTOM DELEGATE

extension MainViewController: DataDelegate{
    func updateArray(newArray: String) {
        
        do{
            NotesArray = try JSONDecoder().decode([Note].self, from: newArray.data(using: .utf8)!)
            print(NotesArray)
        }catch{
            print("Failed to decode")
        }
        
        self.pingTableView?.reloadData()
    }
    
    
}

//MARK:-  Onboarding Code

class core{
    
    static let shared = core()
    
    func isNewUser()->Bool {
        return !UserDefaults.standard.bool(forKey: "onboarding")
    }
    
    func setIsNotNewUser() {
        UserDefaults.standard.set(true, forKey: "onboarding")
    }
}



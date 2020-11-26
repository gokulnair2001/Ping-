//
//  APIFunctions.swift
//  Ping
//
//  Created by Gokul Nair on 25/11/20.
//

import Foundation
import Alamofire

// HEADERS TO PERFORM OPERATION

struct Note: Decodable{
    var _id: String
    var date: String
    var title:String
    var note:String
}

class APIFunctions {
    
    var delegate:DataDelegate?
    // creates and instance of the file so that other files can interact with it
    static let functions = APIFunctions()
    
    //MARK:- NOTES FETCHING FUNCTION
    
    func fetchNotes(){
        
        //Enter your local host URL
        AF.request("http:///fetch").response{ response in
            
            //print(response.data)
            
            let data = String(data: response.data!, encoding: .utf8)
            
            self.delegate?.updateArray(newArray: data!)
            
            
        }
    }
    
    //MARK:- ADD NOTES FUNCTION
    
    func addNote(date: String, title: String, note: String){
        
        //Enter your local host URL
        AF.request("http:///create", method: .post, encoding:  URLEncoding.httpBody, headers: ["title": title, "date": date, "note": note]).responseJSON{response in
            print(response)
            
        }
        
    }
    
    //MARK:- UPDATE NOTES FUNCTION
    
    func updateNote(date: String, title: String, note: String, id: String){
        
        //Enter your local host URL
        AF.request("http:///update",method: .post, encoding: URLEncoding.httpBody,headers: ["title": title, "date": date, "note": note, "id": id]).responseJSON{response in
            print(response)
        }
        
    }
    
    //MARK:- DELETE NOTES FUNCTION
    
    func deleteNote(id: String){
        //Enter your local host URL
        AF.request("http:///delete",method: .post, encoding: URLEncoding.httpBody,headers: ["id": id]).responseJSON{response in
            print(response)
        }
    }
}






//
//  SecondViewController.swift
//  To Do List
//
//  Created by Óscar Calles Sáez on 9/1/15.
//  Copyright (c) 2015 Legua Soft Games. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var toDoItem: UITextField!
    
    @IBOutlet weak var lbEmpty: UILabel!
    @IBAction func addItem(sender: AnyObject) {
        if toDoItem.text == "" {
            lbEmpty.text = "No item name entered"
        } else {
           toDoList.append(toDoItem.text)
        }
        
        
        // Basic persistance for the list items
        storeToDoList()
        
        self.view.endEditing(true)
        toDoItem.text = ""
        
    }
    
    private func storeToDoList(){
        // Basic persistance for the list items
        let fixedToDoList = toDoList
        NSUserDefaults.standardUserDefaults().setObject(fixedToDoList, forKey: "toDoItems")
        NSUserDefaults.standardUserDefaults().synchronize()
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool
    {
        // this hide the keyboard
        textField.resignFirstResponder()
        return true
    }
    
    // needed for hide the keyboard
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }

}


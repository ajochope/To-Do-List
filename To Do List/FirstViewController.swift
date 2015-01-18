//
//  FirstViewController.swift
//  To Do List
//
//  Created by Óscar Calles Sáez on 9/1/15.
//  Copyright (c) 2015 Legua Soft Games. All rights reserved.
//

import UIKit

// this array contains the items in the Table View list
var toDoList:[String] = []


class FirstViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

   
   @IBOutlet var tasksTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       // self.tasksTable.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    
    {
        // table view take the size of the array length
        return toDoList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell")
        //var cell:UITableViewCell = self.tasksTable.dequeueReusableCellWithIdentifier("Cell") as UITableViewCell
        
        // the indexPath.row take the correct item for each row in the table from the array
        cell.textLabel?.text = toDoList[indexPath.row]
        return cell
    }
    // this func run just before the view appear 
    // usefull to run and reaload items when move over screens
    override func viewWillAppear(animated: Bool) {
        
        // call to persitance to fill the table view if exist
        
        if var storedToDoItems: AnyObject? = NSUserDefaults.standardUserDefaults().objectForKey("toDoItems") {
            
            toDoList = [] // first emptying the array
            for var i = 0; i<storedToDoItems?.count; ++i {
                var stringStored = storedToDoItems as Array <String!> // Create new var stringStored (type string) from the storedToDoItems (object)
                toDoList.append(stringStored[i] as NSString)
            }
        }
        tasksTable.reloadData()
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
    {
        // look for user Delete action 
        if (editingStyle == UITableViewCellEditingStyle.Delete){
            toDoList.removeAtIndex(indexPath.row)
            deleteToDoList(indexPath.row)
            tasksTable.reloadData()
        }
    
    }
    
    private func storeToDoList(){
        // Basic persistance for the list items
        let fixedToDoList = toDoList
        NSUserDefaults.standardUserDefaults().setObject(fixedToDoList, forKey: "toDoItems")
        NSUserDefaults.standardUserDefaults().synchronize()
        
    }
    private func deleteToDoList(index:Int){
        // Basic persistance for the list items
        NSUserDefaults.standardUserDefaults().removeObjectForKey("\(index)")
        NSUserDefaults.standardUserDefaults().synchronize()
        
    }
}


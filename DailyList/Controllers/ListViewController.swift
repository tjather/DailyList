//
//  ViewController.swift
//  DailyList
//
//  Created by Talha on 4/10/23.
//

import UIKit

class ListViewController: UITableViewController {

    var listNamesArray = ["List1", "List_2", "3 list"]
    
    var defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let items = defaults.array(forKey: "DailyListKey") as? [String]{
            listNamesArray = items
        }
    }
    
    //Methods to populate data in the tableView
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listNamesArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath)
        
        cell.textLabel?.text = listNamesArray[indexPath.row]
        
        return cell
    }
    
    //Delegate for tableView
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(listNamesArray[indexPath.row])
                
        if(tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark){
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }else{
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //Add items functionality
    @IBAction func addItems(_ sender: UIBarButtonItem) {
        var listName = UITextField()
        
        let newListAlert = UIAlertController(title: "Add New DailyList List", message: "", preferredStyle: .alert)
        
        let addAction = UIAlertAction(title: "Add List", style: .default) { action in
            self.listNamesArray.append(listName.text!)
            
            self.defaults.set(self.listNamesArray, forKey: "DailyListKey")
            
            
            self.tableView.reloadData()
        }
        newListAlert.addTextField { newListFeild in
            newListFeild.placeholder = "Create new list"
            listName = newListFeild
        }
        
        newListAlert.addAction(addAction)
        
        present(newListAlert, animated: true, completion: nil)
        
    }
}


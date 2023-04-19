//
//  ViewController.swift
//  DailyList
//
//  Created by Talha on 4/10/23.
//

import UIKit

class ListViewController: UITableViewController {

    var tasksArray = [Task]()
    
    let tasksFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Tasks.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadTasks()
    }
    
    //Methods to populate data in the tableView
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasksArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for: indexPath)
        
        let task = tasksArray[indexPath.row]
        
        cell.textLabel?.text = task.name
        
        if task.completed == false {
            cell.accessoryType = .none
        }else{
            cell.accessoryType = .checkmark
        }
        
        return cell
    }
    
    //Delegate for tableView
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tasksArray[indexPath.row].completed = !tasksArray[indexPath.row].completed
        
        saveTasks()
                
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //Saving the models
    func saveTasks(){
        let encoder = PropertyListEncoder()
        
        do{
            let data = try encoder.encode(tasksArray)
            try data.write(to: tasksFilePath!)
        }catch{
            print(error)
        }
        
        self.tableView.reloadData()
    }
    
    //Loading the models
    func loadTasks(){
        if let data = try? Data(contentsOf: tasksFilePath!) {
            let decoder = PropertyListDecoder()
            do{
                tasksArray = try decoder.decode([Task].self, from: data)
            }catch{
                print(error)
            }
        }
    }
    
    //Add items functionality
    @IBAction func addItems(_ sender: UIBarButtonItem) {
        var listName = UITextField()
        
        let newListAlert = UIAlertController(title: "Add New DailyList Task", message: "", preferredStyle: .alert)
        
        let addAction = UIAlertAction(title: "Add Task", style: .default) { action in
            let newTask = Task()
            newTask.name = listName.text!
            
            self.tasksArray.append(newTask)
        
            self.saveTasks()
        }
        newListAlert.addTextField { newListFeild in
            newListFeild.placeholder = "Create new task"
            listName = newListFeild
        }
        
        newListAlert.addAction(addAction)
        
        present(newListAlert, animated: true, completion: nil)
        
    }
}


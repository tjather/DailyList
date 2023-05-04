//
//  ViewController.swift
//  DailyList
//
//  Created by Talha on 4/10/23.
//

import UIKit
import RealmSwift

class ListViewController: TableViewController {

    let realm = try! Realm()

    var tasksResults: Results<Task>?
    
    var chosenCategory: Category?{
        didSet{
            loadTasks()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
}
    
    //Methods to populate data in the tableView
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if chosenCategory?.tasks.count == 0{
            return 1
        } else{
            return tasksResults?.count ?? 1
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = super.tableView(tableView, cellForRowAt: indexPath)
        if chosenCategory?.tasks.count == 0{
            cell.textLabel?.text = "You currently have no tasks"
        }else{
            if let task = tasksResults?[indexPath.row] {
                cell.textLabel?.text = task.name
                
                if task.completed == false {
                    cell.accessoryType = .none
                }else{
                    cell.accessoryType = .checkmark
                }
            }else{
                cell.textLabel?.text = "You currently have no tasks"
            }
        }
            
        return cell
    }
    
    //Delegate for tableView
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let task = tasksResults?[indexPath.row]{
            do{
                try realm.write{
//                    realm.delete(task)
                    task.completed = !task.completed
                }
            }catch{
                print(error)
            }
        }
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //Saving the models
    func saveTask(task: Task, current: Category){
        do{
            try realm.write{
                current.tasks.append(task)
            }
        }catch{
            print(error)
        }

        self.tableView.reloadData()
    }
    
    //Deleting the models
    override func deleteCell(at indexPath: IndexPath){
        if let deletedTask = self.tasksResults?[indexPath.row]{
            do{
                try self.realm.write{
                    self.realm.delete(deletedTask)
                }
            }catch{
                print(error)
            }
        }
    }

    //Loading the models
    func loadTasks(){
        tasksResults = chosenCategory?.tasks.sorted(byKeyPath: "name", ascending: true)
        
        tableView.reloadData()
    }
    
    //Add items functionality
    @IBAction func addItems(_ sender: UIBarButtonItem) {
        var listName = UITextField()
        
        let newListAlert = UIAlertController(title: "Add New DailyList Task", message: "", preferredStyle: .alert)
        
        let addAction = UIAlertAction(title: "Add Task", style: .default) { action in
            if let currentCategory = self.chosenCategory {
                let newTask = Task()
                newTask.name = listName.text!
                newTask.createdOn = Date()
                self.saveTask(task: newTask, current: currentCategory)
            }
        }
        
        newListAlert.addTextField { newListFeild in
            newListFeild.placeholder = "Create new task"
            listName = newListFeild
        }
        
        newListAlert.addAction(addAction)
        
        present(newListAlert, animated: true, completion: nil)
    }
}

extension ListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        tasksResults = tasksResults?.filter("name CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "createdOn", ascending: true)
        
        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadTasks()
            
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }
        }
    }
}


//
//  CategoryViewController.swift
//  DailyList
//
//  Created by Talha on 4/10/23.
// Uses a SwipeCellKit Library from https://github.com/SwipeCellKit/SwipeCellKit

import UIKit
import RealmSwift

class CategoryViewController: TableViewController {

    let realm = try! Realm()
    
    var categoriesResults: Results<Category>?
    
    //Template Desgin Pattern for viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCategories()
    }

    //Methods to populate data in the tableView
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(categoriesResults?.count == 0){
            return 1
        }else{
            return categoriesResults?.count ?? 1
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = super.tableView(tableView, cellForRowAt: indexPath)

        if categoriesResults?.count == 0 {
            cell.textLabel?.text = "You currently have no categories"
        }else{
            cell.textLabel?.text = categoriesResults?[indexPath.row]["name"] as? String ?? "You currently have no categories"
        }
                
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let segueVC = segue.destination as! ListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow{
            segueVC.chosenCategory = categoriesResults?[indexPath.row]
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "viewTasks", sender: self)
    }
    
    //Saving the models
    func saveCategory(category: Category){
        do{
            try realm.write{realm.add(category)}
        }catch{
            print(error)
        }
        
        self.tableView.reloadData()
    }
    
    //Deleting the models using the Template Desgin Pattern
    override func deleteCell(at indexPath: IndexPath){
        if let deletedCategory = self.categoriesResults?[indexPath.row]{
            do{
                try self.realm.write{
                    self.realm.delete(deletedCategory)
                }
            }catch{
                print(error)
            }
        }
    }
    
    //Loading the models
    func loadCategories(){
        categoriesResults = realm.objects(Category.self)
        
        tableView.reloadData()
    }
    
    @IBAction func addCategory(_ sender: UIBarButtonItem) {
        var categoryName = UITextField()

        let newCategoryAlert = UIAlertController(title: "Add New DailyList Task", message: "", preferredStyle: .alert)
    
        let addAction = UIAlertAction(title: "Add Category", style: .default) { action in
            let newCategory = Category()
            newCategory.name = categoryName.text!
                    
            self.saveCategory(category: newCategory)
        }
        
        newCategoryAlert.addTextField { newCategoryFeild in
            newCategoryFeild.placeholder = "Create new category"
            categoryName = newCategoryFeild
        }
        
        newCategoryAlert.addAction(addAction)
        
        present(newCategoryAlert, animated: true, completion: nil)
    }
    
}

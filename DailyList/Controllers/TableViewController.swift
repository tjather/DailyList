//
//  TableViewController.swift
//  DailyList
//
//  Created by Talha on 5/3/23.
//

import UIKit
import SwipeCellKit

class TableViewController: UITableViewController, SwipeTableViewCellDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 100.0
    }

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }

        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            // handle action by updating model with deletion
            self.deleteCell(at: indexPath)
            tableView.reloadData()
        }

        // customize the action appearance
        deleteAction.image = UIImage(named: "trash")

        return [deleteAction]
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                let cell  = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SwipeTableViewCell
                
                cell.delegate = self
                
                return cell
    }
    
    func deleteCell(at indexPath: IndexPath){
        //Delete Cells
    }
}

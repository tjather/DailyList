//
//  Task.swift
//  DailyList
//
//  Created by Talha on 4/19/23.
//

import Foundation
import RealmSwift

class Task: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var completed: Bool = false
    @objc dynamic var createdOn: Date?
    var assignedCategory = LinkingObjects(fromType: Category.self, property: "tasks")
}

//class Task: Codable {
//    var name: String = ""
//    var completed: Bool = false
//}

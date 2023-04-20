//
//  Category.swift
//  DailyList
//
//  Created by Talha on 4/20/23.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    let tasks = List<Task>()
}

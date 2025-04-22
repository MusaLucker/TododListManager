//
//  TodoItem+CoreDataProperties.swift
//  TodoUIKit
//
//  Created by MusaIstema on 18.04.2025.
//
//

import Foundation
import CoreData
@objc(TodoItem)
public class TodoItem: NSManagedObject {

}


extension TodoItem {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TodoItem> {
        return NSFetchRequest<TodoItem>(entityName: "TodoItem")
    }

    @NSManaged public var title: String?
    @NSManaged public var descript: String?
    @NSManaged public var id: String?
    @NSManaged public var completed: Bool
    @NSManaged public var date: Date?

}

extension TodoItem : Identifiable {

}

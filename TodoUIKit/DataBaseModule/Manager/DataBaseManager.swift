//
//  DataBaseManager.swift
//  TodoUIKit
//
//  Created by MusaIstema on 18.04.2025.
//

import SwiftUI
import Combine
import CoreData
import UIKit

final class DataBaseManager {
    static let shared = DataBaseManager()
    private init() {}
    var todoItems:[TodoItem] = []
    //MARK: Container
    private lazy var fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "TodoItem")
    lazy var persistentContainter:NSPersistentContainer =  {
        let contrainter = NSPersistentContainer(name: "TodoItemModel")
        contrainter.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("Error: \(error), \(error.userInfo)")
            }else {
                print("Databas - \(storeDescription.url?.absoluteString ?? "")")
            }
        }
        return contrainter
    }()
    //Save context
    private func saveContext() {
        let context = persistentContainter.viewContext
        if context.hasChanges {
            do {
                try context.save()
                print("Success")
            }catch {
                print("error")
                let nserror = error as NSError
                fatalError("Error: \(nserror), \(nserror.userInfo)")
            }
        }
    }
    //Predicate
    private func predicate(id:String) {
        self.fetchRequest.predicate = NSPredicate(format: "id == %lld", id)
    }
    
    //Create
    func createTodoItem(title:String,descript:String?,completed:Bool) {
        let todoItemId = UUID().uuidString
        let _ :TodoItem = {
            $0.id = todoItemId
            $0.title = title
            if let descript {
                $0.descript = descript
            } else {
                $0.descript = "Go to the park and walk and breath the frash air"
            }
            $0.completed = completed
            $0.date = Date()
            return $0
        }(TodoItem(context: persistentContainter.viewContext))
        self.saveContext()
    }
    //Fetch
    func fetchTodoItems(){
        let request = TodoItem.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)]
        do {
            let todoItems = try  persistentContainter.viewContext.fetch(request)
            self.todoItems = todoItems
            print(todoItems.count)
        } catch {
            print(error.localizedDescription )
        }
    }
    //Update
    func updateTodoItem(id:String, title:String, descript:String) {
        let context = persistentContainter.viewContext
        print("Save")
        do {
            let todoItems = try? context.fetch(self.fetchRequest) as? [TodoItem]
            if var todoItem = todoItems?.first(where: {$0.id == id}) {
                todoItem.descript = descript
                todoItem.title = title
                todoItem.date = Date()
            
                print(title)
                print(todoItem.descript)
            }
            self.saveContext()
        }
    }
    //Delete
    func deleteTodoItem(title:String) {
        let context = persistentContainter.viewContext
        print("Deleted")
        do {
            let todoItems = try context.fetch(self.fetchRequest) as? [TodoItem]
            if let todoItem = todoItems?.first(where: {$0.title == title}) {
                context.delete(todoItem)
                print("good")
            }
            self.saveContext()
        }catch {
            print(error.localizedDescription)
        }

    }
    //Toggle
    func toggleComleted(id:String) {
        let context = persistentContainter.viewContext
        do {
            let todoItems = try? context.fetch(self.fetchRequest) as? [TodoItem]
            let todoItem = todoItems?.first(where: {$0.id == id})
            todoItem?.completed = !todoItem!.completed
            todoItem?.date = Date()
            self.saveContext()
        }

    }
    
}

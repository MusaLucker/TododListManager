//
//  NetworkManager.swift
//  TodoUIKit
//
//  Created by MusaIstema on 17.04.2025.
//

import Foundation
import CoreData
protocol HTTPClientProtocol {
    func fetchTodoItems(url:String, completion:@escaping (Result<[TodoItem],NetworkError>) -> Void)
}

final class NetworkManager:HTTPClientProtocol {
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
      private let decoder = JSONDecoder()
    func loadTodoItemsFromLocal(completion:@escaping ([TodoItem])->Void)  {
        DataBaseManager.shared.fetchTodoItems()
        completion(DataBaseManager.shared.todoItems)
    }
    func fetchTodoItems(url:String, completion:@escaping (Result<[TodoItem],NetworkError>)->Void) {
        //change into Todo
        guard let url = URL(string: url) else {return}
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        //Fetch data
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                guard error == nil else {
                    completion(.failure(.noData))
                    return
                }
                //if we have a response
                let urlResponse  = response as? HTTPURLResponse
                guard urlResponse?.statusCode != 409 else {
                    completion(.failure(.tooManyRequests))
                    return
                }
                guard let safeData = data else {return}
                do {
                    let todoData = try self.decoder.decode(TodoModel.self, from: safeData)
                                    let context = self.persistentContainter.viewContext
                                    for todo in todoData.todos {
                                        let todoEntity = TodoItem(context: context)
                                        todoEntity.id = UUID().uuidString
                                        todoEntity.date = Date()
                                        todoEntity.descript = "Go to the park and walk and breath the frash air"
                                        todoEntity.title = todo.todo
                                        todoEntity.completed = todo.completed
                    
                                    }
                                    try context.save()
                                    DataBaseManager.shared.fetchTodoItems()
                    completion(.success(DataBaseManager.shared.todoItems))
                }catch let error {
                    print(error.localizedDescription)
                    completion(.failure(.decodeError))
                }
        }
        task.resume()
        UserDefaults.standard.set(true, forKey: "loaded")
    }
    
}

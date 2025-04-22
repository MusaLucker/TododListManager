//
//  MainInteractor.swift
//  TodoUIKit
//
//  Created by MusaIstema on 17.04.2025.
//

import Foundation

protocol MainInteractorProtocol:AnyObject {
    func loadTodoItems()
    func loadTodoItemsFromLocal()
}

class MainInteractor {
    //MARK: - var/let
    weak var presenter:MainPresenterProtocol?
    private let networkManager = NetworkManager()
    private let databaseManager = DataBaseManager.shared
    private var todoItems:[TodoItem] = []
}


//MARK: - MainInteractorProtocol
extension MainInteractor:MainInteractorProtocol {
    func loadTodoItems() {
        self.networkManager.fetchTodoItems(url:NetworkLink.user.url) { result in
            switch result {
            case .success(let todoItems):
                self.presenter?.didLoadTodo(items: todoItems)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    func loadTodoItemsFromLocal() {
        self.networkManager.loadTodoItemsFromLocal { todoItems in
            self.presenter?.didLoadTodo(items: todoItems)
        }
    }
    
}


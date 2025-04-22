//
//  ViewController.swift
//  TodoUIKit
//
//  Created by MusaIstema on 17.04.2025.
//

import UIKit
import SwiftUI
protocol AddViewDelegate {
    func createTodoItem(title:String,description:String)
    func deleteTodoItem(title:String)
    func showEdit(id:String,title:String,description:String,time:Date)
}

protocol MainViewProtocol:AnyObject {
    func loadTodo(items:[TodoItem])
}

class MainView: UIViewController{
    var presenter:MainPresenterProtocol?
    private var todoItems:[TodoItem] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.didLoad()
        let contentView = ProgressViewContent(todoItems: self.todoItems, delegate: self)
        let content = UIHostingController(rootView: contentView)
        addChild(content)
        content.view.frame = view.frame
        view.addSubview(content.view)
        content.didMove(toParent: self)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let contentView = MainViewContent(todoItems: self.todoItems, delegate: self)
        let content = UIHostingController(rootView: contentView)
        addChild(content)
        content.view.frame = view.frame
        view.addSubview(content.view)
        content.didMove(toParent: self)
    }
   

}
//MARK: - MainViewProtocol
extension MainView:MainViewProtocol {
    
    func loadTodo(items: [TodoItem]) {
            onMainThread {
                self.todoItems = items
                self.viewWillAppear(true)
        }
    }
}

extension MainView:AddViewDelegate {
    func showEdit(id:String,title:String,description:String,time:Date) {
        self.presenter?.didTapEdit(id:id,title:title,description:description,time:time)
    }
    
    func deleteTodoItem(title: String) {
        DataBaseManager.shared.deleteTodoItem(title: title)
        self.presenter?.didLoad()
        self.viewWillAppear(true)
        print(DataBaseManager.shared.todoItems.count)
    }
    
    func createTodoItem(title:String,description:String) {
        DataBaseManager.shared.createTodoItem(title:title, descript: description, completed: false)
        self.presenter?.didLoad()
    }
    func editTodoItem(id:String,title: String,description:String) {
        DataBaseManager.shared.updateTodoItem(id: id, title: title, descript: description)
    }
}

//
//  MainPresenter.swift
//  TodoUIKit
//
//  Created by MusaIstema on 17.04.2025.
//

import Foundation

protocol MainPresenterProtocol:AnyObject {
    func didLoadTodo(items:[TodoItem])
    func didLoad()
    func didTapEdit(id:String,title:String,description:String,time:Date)
}


class MainPresenter {
    //MARK: - var/let
    weak var view:MainView?
    var interactor:MainInteractorProtocol
    var router:MainRouterProtocol
    
    init(interactor: MainInteractorProtocol, router: MainRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

//MARK: - MainPresenterProtocol
extension MainPresenter:MainPresenterProtocol {

    func didLoadTodo(items: [TodoItem]) {
        view?.loadTodo(items: items)
    }
    func didLoad() {
        if UserDefaults.standard.bool(forKey:"loaded") {
            interactor.loadTodoItemsFromLocal()
        }else {
            interactor.loadTodoItems()
        }

    }
    func didTapEdit(id:String,title:String,description:String,time:Date) {
        router.showEdit(id:id,title:title,description:description,time:time)
    }
    
}


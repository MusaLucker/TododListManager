//
//  EditPresenter.swift
//  TodoUIKit
//
//  Created by MusaIstema on 17.04.2025.
//

import Foundation

protocol EditPresenterProtocol:AnyObject {
    func didClose()
    func didLoadTodoItem(id:String,title:String,description:String,time:Date)
    func viewDidLoad()
}


class EditPresenter {
    //MARK: - var/let
    weak var view:EditView?
    var interactor:EditInteractorProtocol
    var router:EditRouterProtocol
    init(interactor: EditInteractorProtocol, router: EditRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

//MARK: - EditPresenterProtocol
extension EditPresenter:EditPresenterProtocol {
    func didLoadTodoItem(id: String, title: String, description: String, time: Date) {
        self.view?.showTodoItem(id: id, title: title, description: description, time: time)
        
    }
    
    func didClose() {
        router.closeEdit()
    }
    func viewDidLoad() {
        self.interactor.loadTodoItem()
    }
}

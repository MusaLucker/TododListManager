//
//  EditInteractor.swift
//  TodoUIKit
//
//  Created by MusaIstema on 17.04.2025.
//

import Foundation
protocol EditInteractorProtocol:AnyObject {
    func loadTodoItem()
}

class EditInteractor {
    //MARK: - var/let
    weak var presenter:EditPresenterProtocol?
    var id:String
    var title:String
    var description:String
    var time:Date
    init(id:String, title: String, description: String, time: Date) {
        self.id = id
        self.title = title
        self.description = description
        self.time = time
    }

}

//MARK: - EditInteractorProtocol
extension EditInteractor:EditInteractorProtocol {
    func loadTodoItem() {
        self.presenter?.didLoadTodoItem(id: id, title: title, description: description, time: time)
    }
}

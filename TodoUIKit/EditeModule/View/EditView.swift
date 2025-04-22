//
//  EditView.swift
//  TodoUIKit
//
//  Created by MusaIstema on 17.04.2025.
//


import UIKit
import SwiftUI
protocol EditViewDelegate {
    func close()
}

protocol EditViewProtocol:AnyObject {
    func showTodoItem(id: String, title: String, description: String, time: Date)
}

class EditView: UIViewController{
    //MARK: - var/let
    var presenter:EditPresenterProtocol?
    var editTitle: String = ""
    var editDescript: String = ""
    var editId:String = ""
    var date:Date = Date()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter?.viewDidLoad()
        let contentView = EditViewContent(id:editId, title:editTitle, desciption:editDescript,date: date.dateIntoString(), delegate: self)
        let content = UIHostingController(rootView: contentView)
        addChild(content)
        content.view.frame = view.frame
        view.addSubview(content.view)
        content.didMove(toParent: self)
    }

}
//MARK: - EditViewProtocol
extension EditView:EditViewProtocol {
    func showTodoItem(id: String, title: String, description: String, time: Date) {
        self.editId = id
        self.editTitle = title
        self.editDescript = description
        self.date = time
    }
}
//MARK: - EditViewDelegate
extension EditView:EditViewDelegate {
    func close() {
        self.presenter?.didClose()
    }
    
    
}

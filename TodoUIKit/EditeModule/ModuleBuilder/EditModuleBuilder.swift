//
//  EditModuleBuilder.swift
//  TodoUIKit
//
//  Created by MusaIstema on 17.04.2025.
//

import UIKit

class EditModuleBuilder {
    static func build(id:String,title:String,description:String,time:Date) -> UIViewController {
        let interactor = EditInteractor(id: id, title: title, description: description, time: time)
        let router = EditRouter()
        let presenter = EditPresenter(interactor: interactor, router:router )
        let editView = EditView(nibName: nil, bundle: nil)
        editView.presenter = presenter
        presenter.view = editView
        interactor.presenter = presenter
        router.view = editView
        return editView
    }
}

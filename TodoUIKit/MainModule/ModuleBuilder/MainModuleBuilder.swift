//
//  MainModuleBuilder.swift
//  TodoUIKit
//
//  Created by MusaIstema on 17.04.2025.
//

import UIKit

class MainModuleBuilder {
    static func build() -> UIViewController {
        let interactor = MainInteractor()
        let router = MainRouter()
        let presenter = MainPresenter(interactor: interactor, router:router )
        let mainView = MainView(nibName: nil, bundle: nil)
        mainView.presenter = presenter
        presenter.view = mainView
        interactor.presenter = presenter
        router.view = mainView
        return mainView
    }
}

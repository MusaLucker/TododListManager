//
//  MainRouter.swift
//  TodoUIKit
//
//  Created by MusaIstema on 17.04.2025.
//

import Foundation

protocol MainRouterProtocol:AnyObject {
    func showEdit(id:String,title:String,description:String,time:Date)
}

class MainRouter {
    weak var view:MainView?
}


//MARK: - MainRouterProtocol
extension MainRouter:MainRouterProtocol {
    func showEdit(id:String,title:String,description:String,time:Date) {
        let editView = EditModuleBuilder.build(id:id,title:title,description:description,time:time)
        self.view?.navigationController?.pushViewController(editView, animated: true)
    }
    
    
}

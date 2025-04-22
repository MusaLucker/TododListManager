//
//  EditRouter.swift
//  TodoUIKit
//
//  Created by MusaIstema on 17.04.2025.
//

import Foundation
import UIKit

protocol EditRouterProtocol:AnyObject {
    func closeEdit()
}

class EditRouter {
    //MARK: - var/let
    weak var view:EditView?
}


//MARK: - EditRouterProtocol
extension EditRouter:EditRouterProtocol {
    func closeEdit() {
        self.view?.navigationController?.popViewController(animated: true)
    }
}

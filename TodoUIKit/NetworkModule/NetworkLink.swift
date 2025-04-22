//
//  NetworkLink.swift
//  TodoUIKit
//
//  Created by MusaIstema on 17.04.2025.
//

import Foundation

//MARK: - Network Links
enum NetworkLink {
    case user
    var url:String {
        switch self {
        case .user:
            return "https://dummyjson.com/todos"
        }
    }
    
}

//
//  TaskModel.swift
//  TodoUIKit
//
//  Created by MusaIstema on 17.04.2025.
//

import Foundation
struct MocoData:Identifiable,Hashable {
    var id:UUID = UUID()
    var name:String
    var description:String
    var status:Bool
    var date:Date
}





struct Todo:Codable {
    var id:Int
    var todo:String
    var completed:Bool
    var userId:Int
}
struct TodoModel:Codable {
    var todos:[Todo]
    var total:Int
    var skip:Int
    var limit:Int
}
//extension TaskModel3:Identifiable {
//    var id:UUID {
//        UUID()
//    }
//}

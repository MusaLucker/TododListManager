//
//  Int-Extentions.swift
//  TodoUIKit
//
//  Created by MusaIstema on 17.04.2025.
//

import Foundation
extension Int {
    func convertIntoString() -> String {
        let stringNumber = String(self)
        let stringArray = Array(stringNumber)
        let lastChar = String(stringArray[stringArray.count - 1])
        let intNumber = Int(lastChar)
        if self == 10 || self > 10 && self < 20 {
            return "\(self) Задач"
        }else {
            switch intNumber ?? 0 {
            case 1: return "\(self) Задача"
            case 2...4: return "\(self) Задачи"
            default:
                return "\(self) Задач"
            }
        }
    }
}

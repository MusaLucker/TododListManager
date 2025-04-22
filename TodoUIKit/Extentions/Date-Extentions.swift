//
//  Date-Extentions.swift
//  TodoUIKit
//
//  Created by MusaIstema on 19.04.2025.
//

import Foundation

extension Date {
    func dateIntoString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yy"
        return dateFormatter.string(from: self)
    }
}

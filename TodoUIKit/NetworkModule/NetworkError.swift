//
//  NetworkError.swift
//  TodoUIKit
//
//  Created by MusaIstema on 17.04.2025.
//

import Foundation

enum NetworkError:String,Error {
    case noData = "No data"
    case tooManyRequests = "Too many requests"
    case decodeError = "Decoding error"
}

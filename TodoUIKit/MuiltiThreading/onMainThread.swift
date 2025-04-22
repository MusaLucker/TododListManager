//
//  onMainThread.swift
//  TodoUIKit
//
//  Created by MusaIstema on 18.04.2025.
//

import Foundation

//MARK: - On main thread
public func onMainThread(_ block:@escaping ()->Void) {
    if Thread.isMainThread {
        block()
    }else {
        DispatchQueue.main.async(execute: block)
    }
}

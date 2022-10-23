//
//  Box.swift
//  Box
//
//  Created by Kuziboev Siddikjon on 10/23/22.
//

import Foundation

final class Box<T> {
    
    typealias  Listenar = (T) -> Void
    private  var listenar: Listenar?
    
    var value: T {
        didSet {
            listenar?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    func subscribe(listenar: @escaping Listenar) {
        self.listenar = listenar
    }
    
}


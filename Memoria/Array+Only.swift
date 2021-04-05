//
//  Array+Only.swift
//  Memoria
//
//  Created by Pedro Henrique on 15/03/21.
//

import Foundation

extension Array {
    
    var only: Element? {
        count == 1 ? first : nil
    }
    
}

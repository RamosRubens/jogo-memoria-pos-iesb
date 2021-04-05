//
//  Array+Identifiable.swift
//  Memoria
//
//  Created by Pedro Henrique on 15/03/21.
//

import Foundation

extension Array where Element: Identifiable {
    
    func firstIndex(matching: Element) -> Int? {
        for index in 0..<count {
            if self[index].id == matching.id {
                return index
            }
        }
        return nil
    }
    
}

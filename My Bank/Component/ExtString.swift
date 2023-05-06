//
//  ExtString.swift
//  My Bank
//
//  Created by Prizega  on 06/05/23.
//

import Foundation

extension String {
    
    func trim(_ characterSet: CharacterSet) -> String {
            return self.trimmingCharacters(in: characterSet)
    }
}

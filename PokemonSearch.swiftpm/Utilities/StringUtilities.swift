//
//  File.swift
//  
//
//  Created by Victor Ronnerstedt on 2023-07-28.
//

import Foundation

extension String {
    func capitalizeFirstLetter() -> String {
       guard !isEmpty else {
           return self
       }
       let firstChar = prefix(1).capitalized
       let remainingChars = dropFirst()
       return firstChar + remainingChars
    }
}

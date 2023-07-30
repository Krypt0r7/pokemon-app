//
//  File.swift
//  
//
//  Created by Victor Ronnerstedt on 2023-07-28.
//

import Foundation

struct StringUtilities {
    func capitalizeFirstLetter(_ input: String) -> String {
       guard !input.isEmpty else {
           return input
       }
       let firstChar = input.prefix(1).capitalized
       let remainingChars = input.dropFirst()
       return firstChar + remainingChars
    }
}

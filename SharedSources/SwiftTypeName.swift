//
//  SwiftTypeName.swift
//  JSON to Swift Converter
//
//  Created by Brian Arnold on 2/21/17.
//  Copyright © 2017 Brian Arnold. All rights reserved.
//

extension String {
    
    /// Used to determine whether to capitalize for a Swift type, or to use lowercase for a name.
    internal enum SwiftTypeName {
        case type
        case name
    }
    
    /// Returns a camelCase version of this string with spaces removed. 
    /// Each space in the name denotes a new capitalized word.
    ///
    /// - Parameter typeName: Capitalizes the beginning of the string if `.type`, 
    ///                       otherwise starts lowercase if `.name`.
    internal func camelCase(_ typeName: SwiftTypeName) -> String {
        guard self.characters.count > 0 else { return self }
        var newString: String = ""
        
        let first = String(Character(self.unicodeScalars.first!))
        newString.append(typeName == .type ? first.uppercased() : first.lowercased())
        var capitalizeNext = false
        for scalar in self.unicodeScalars.dropFirst() {
            if capitalizeNext {
                let uppercaseCharacter = String(Character(scalar)).uppercased()
                newString.append(uppercaseCharacter)
                capitalizeNext = false
            } else if scalar == " " {
                capitalizeNext = true
            } else {
                let character = Character(scalar)
                newString.append(character)
            }
        }
        
        return newString
    }
    
    /// Returns this string in camelCase with lowercase character first and spaces removed.
    public var swiftName: String {
        return camelCase(.name)
    }
    
    /// Returns this string in camelCase with uppercase character first and spaces removed.
    public var swiftType: String {
        return camelCase(.type)
    }
}

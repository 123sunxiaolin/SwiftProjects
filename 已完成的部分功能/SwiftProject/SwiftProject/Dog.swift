//
//  Dog.swift
//  SwiftProject
//
//  Created by LTHJ on 2017/1/18.
//  Copyright © 2017年 LTHJ. All rights reserved.
//

import UIKit

// MARK: code for error test
enum DogError: Error{
    case NameInvalidError
    case AgeInvaildError
    case NameLengthError
}

class Dog: NSObject {
    var name: String!
    var age: Int!
    
    init(name: String, age: Int) {
        super.init()
        self.name = name
        self.age = age
    }
    
    func printDogMsg(dog: Dog) throws -> String {
        guard let name = dog.name else {
            throw DogError.NameInvalidError
        }
        
        if name.characters.count < 3{
            throw DogError.NameLengthError
        }
        
        guard let age = dog.age else {
            throw DogError.AgeInvaildError
        }
        
        if age < 10 || age > 20 {
            throw DogError.AgeInvaildError
        }
        
        return "name:\(name) age:\(age)"
    }
    
}

//
//  Аuthor.swift
//  Famous Quote Quiz
//
//  Created by Dobromir Penev on 26.06.18.
//  Copyright © 2018 Dobromir Penev. All rights reserved.
//

import Foundation

class Author {
    
    let name : String
    let authentic : Bool
    
    init(authorName: String, authentic: Bool) {
        self.name = authorName
        self.authentic = authentic
    }
    
    init() {
        self.name = ""
        self.authentic = false
    }
    
}

//
//  Question.swift
//  Famous Quote Quiz
//
//  Created by Dobromir Penev on 26.06.18.
//  Copyright © 2018 Dobromir Penev. All rights reserved.
//

import Foundation

class Question {
    
    let quoteText : String
    var authors : [Author]

    init(text : String, authors : [Author]) {
        self.quoteText = text
        self.authors = authors
    }
    
}

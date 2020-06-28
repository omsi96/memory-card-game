//
//  Card.swift
//  MemoryCardApp
//
//  Created by Omar Alibrahim on 6/29/20.
//  Copyright © 2020 KuwaitCodes. All rights reserved.
//

import Foundation

struct Card: Hashable, Equatable{
    var type: String
    var number: String
    
    func imageName() -> String{
        return type + "-" + number 
    }
    
    static var allCards: [Card] = [
        Card(type: "Clove", number: "K"),
        Card(type: "Clove", number: "A"),

        Card(type: "Diamond", number: "K"),
        Card(type: "Diamond", number: "A"),

        Card(type: "Spade", number: "K"),
        Card(type: "Spade", number: "A"),
        
        Card(type: "Heart", number: "K"),
        Card(type: "Heart", number: "A"),
    ]
    
    
}

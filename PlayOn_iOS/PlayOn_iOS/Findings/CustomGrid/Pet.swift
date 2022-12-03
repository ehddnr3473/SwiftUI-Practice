//
//  Pet.swift
//  PlayOn_iOS
//
//  Created by 김동욱 on 2022/12/03.
//

import Foundation

// Data Model object
// ForEach에서 타입을 쉽게 사용할 수 있도록 Identifiable과 변경 사항을 애니메이션화할 수 있는 Equtable
struct Pet: Identifiable, Equatable {
    let type: String
    var votes: Int = 0
    var id: String { type }
    
    static var exampleData: [Pet] = [
        Pet(type: "Cat", votes: 25),
        Pet(type: "Goldfish", votes: 9),
        Pet(type: "Dog", votes: 16)
    ]
    
    static var totalVotes: Int {
        var total = 0
        for pet in Pet.exampleData {
            total += pet.votes
        }
        return total
    }
}

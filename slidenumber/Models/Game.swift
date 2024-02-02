//
//  Game.swift
//  slidenumber
//
//  Created by Supakrit Nithikethkul on 3/2/2567 BE.
//

import Foundation

class Game: ObservableObject {
    private(set) var numbers: Array<String>
    var gameSize: Int = 4
    @Published var count = 0
    @Published var theResult = ""
    
    init(_ gameSize: Int = 4) {
        self.gameSize = gameSize
        numbers = []
        for i in 0..<(gameSize*gameSize)-1 {
            let number = String(i)
            numbers.append(number)
        }
        numbers.append("")
        shuffle()
    }
    
    func move(_ number: String, direction: String) -> String {
        let chosenIndex = index(of: number)
        switch direction {
        case "Left":
            numbers.swapAt(chosenIndex, chosenIndex-1)
        case "Right":
            numbers.swapAt(chosenIndex, chosenIndex+1)
        case "Up":
            numbers.swapAt(chosenIndex, chosenIndex-gameSize)
        case "Down":
            numbers.swapAt(chosenIndex, chosenIndex+gameSize)
        default:
            print("Error at move function!")
        }
        return result()
    }
    
    private func index(of number: String) -> Int {
        for index in numbers.indices {
            if numbers[index] == number {
                return index
            }
        }
        return 0
    }
    
    func shuffle() {
        numbers.shuffle()
    }
    
    func result() -> String {
        for index in numbers.indices {
            if numbers[index] != String(index+1) {
                count+=1
                return ""
            }
        }
        return "You Won!!!"
    }
    
    func newGame() {
        self.count = 0
        shuffle()
    }
}

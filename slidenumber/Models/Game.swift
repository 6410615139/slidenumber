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
        for i in 1..<(gameSize*gameSize) {
            let number = String(i)
            numbers.append(number)
        }
        numbers.append("")
        shuffle()
    }
    
    func move(_ number: String, direction: String) {
        let chosenIndex = index(of: number)
        if direction == "Left" {
            if (chosenIndex-1 >= 0) && (chosenIndex % gameSize != 0) && numbers[chosenIndex-1] == "" {
                numbers.swapAt(chosenIndex, chosenIndex-1)
                count+=1
                result()
            }
        } else if direction == "Right" {
            if (chosenIndex+1 < numbers.count) && (chosenIndex % gameSize != gameSize-1) && numbers[chosenIndex+1] == "" {
                numbers.swapAt(chosenIndex, chosenIndex+1)
                count+=1
                result()
            }
        } else if direction == "Up" {
            if (chosenIndex-gameSize >= 0) && numbers[chosenIndex-gameSize] == "" {
                numbers.swapAt(chosenIndex, chosenIndex-gameSize)
                count+=1
                result()
            }
        } else if direction == "Down" {
            if (chosenIndex+gameSize < numbers.count) && numbers[chosenIndex+gameSize] == "" {
                numbers.swapAt(chosenIndex, chosenIndex+gameSize)
                count+=1
                result()
            }
        } else {
            print("Error on move function!")
        }
    }
    
    private func index(of number: String) -> Int {
        for index in numbers.indices {
            if numbers[index] == number {
                return index
            }
        }
        return 0
    }
    
    func shuffle(times: Int=1000) {
        var my_times = times
        for _ in 1...my_times {
            let chosenIndex = index(of: "")
            let direction = ["Left", "Right", "Up", "Down"].randomElement()
            if direction == "Left" {
                if (chosenIndex % gameSize != 0) {
                    numbers.swapAt(chosenIndex, chosenIndex-1)
                } else {
                    my_times+=1
                }
            } else if direction == "Right" {
                if (chosenIndex % gameSize != gameSize-1) {
                    numbers.swapAt(chosenIndex, chosenIndex+1)
                } else {
                    my_times+=1
                }
            } else if direction == "Up" {
                if (chosenIndex-gameSize >= 0) {
                    numbers.swapAt(chosenIndex, chosenIndex-gameSize)
                } else {
                    my_times+=1
                }
            } else if direction == "Down" {
                if (chosenIndex+gameSize < numbers.count) {
                    numbers.swapAt(chosenIndex, chosenIndex+gameSize)
                } else {
                    my_times+=1
                }
            }
        }
    }
    
    func result() {
        var check = 0
        for index in numbers.indices {
            if numbers[index] == String(index+1) {
                check+=1
            }
        }
        if check == numbers.count-1 {
            theResult = "You Won!!!"
        } else {
            theResult = ""
        }
    }
    
    func newGame() {
        self.count = 0
        theResult = ""
        shuffle()
    }
}

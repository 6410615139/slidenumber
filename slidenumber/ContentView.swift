//
//  ContentView.swift
//  slidenumber
//
//  Created by Supakrit Nithikethkul on 3/2/2567 BE.
//

import SwiftUI

struct ContentView: View {
    @StateObject var game = Game()
    
    let spacing = 4 as CGFloat
    let aspectRatio = 1 as CGFloat
    var body: some View {
    VStack {
        Button("New game") {
            game.newGame()
        }
        .font(.largeTitle)
        .colorMultiply(.green)
        
        GeometryReader { geometry in
            let aspectRatio = 1 as CGFloat
            let width = geometry.size.width / Double(game.gameSize)
            let height = geometry.size.height / Double(game.gameSize)
            let gridItemSize = min(width, height * aspectRatio)
                    
            LazyVGrid(columns: Array(repeating: GridItem(.fixed(gridItemSize), spacing: 0), count: game.gameSize), spacing: 0) {
                ForEach(game.numbers, id: \.self) { number in
                    NumberView(number: number, game: game)
                        .aspectRatio(aspectRatio, contentMode: .fit)
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height) // Use the full available space
            .foregroundColor(.pink)
        }

        
        Text(game.theResult)
            .font(.title3)
            .fontWeight(.bold)
            .foregroundColor(.green)
            .padding()
        
        Text("Move: " + String(game.count))
            .font(.largeTitle)
            
    }
    .padding()
    }
}

struct NumberView: View {
    var number: String
    @State var swipeDirection: String = ""
    @ObservedObject var game: Game
    
    var body: some View {
        ZStack {
            if number != "" {
                let base = RoundedRectangle(cornerRadius: 12)
                Group {
                    base.foregroundColor(.white)
                    base.strokeBorder(lineWidth: 2)
                    Text(number)
                        .font(.system(size: 20))
                        .bold()
                }
                .gesture(
                    DragGesture(minimumDistance: 10)
                        .onEnded { value in
                        if abs(value.translation.width) > abs(value.translation.height) {
                            // Horizontal swipe
                            swipeDirection = value.translation.width > 0 ? "Right" : "Left"
                        } else {
                            // Vertical swipe
                            swipeDirection = value.translation.height > 0 ? "Down" : "Up"
                        }
                        // add animation
                        withAnimation(.default) {
                        game.move(number, direction: swipeDirection)
                        }
                    }
                )
            }
        }
    }
}

#Preview {
    ContentView()
}

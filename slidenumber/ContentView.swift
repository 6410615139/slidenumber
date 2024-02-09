//
//  ContentView.swift
//  slidenumber
//
//  Created by Supakrit Nithikethkul on 3/2/2567 BE.
//

import SwiftUI

struct ContentView: View {
    @StateObject var game = Game()
    
    var body: some View {
    VStack {
        Button("New game") {
            game.newGame()
        }
        .font(.largeTitle)
        .colorMultiply(.green)
        
        LazyVGrid(columns:
            [GridItem(), GridItem(),GridItem(), GridItem()]) {
            ForEach(game.numbers, id: \.self) {number in
                NumberView(number: number, game: game)
                    .aspectRatio(1, contentMode: .fit)
            }
        }
        .foregroundColor(.pink)
        Spacer()
        
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
                        withAnimation(.easeInOut(duration: 0.5)) {
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

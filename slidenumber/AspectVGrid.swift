//
//  AspectVGrid.swift
//  slidenumber
//
//  Created by Supakrit Nithikethkul on 9/2/2567 BE.
//

import SwiftUI

struct AspectVGrid<ItemView: View>: View {
    var items: [String]
    var aspectRatio: CGFloat
    var content: (String) -> ItemView
    let temp: CGFloat = 4
    
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width / temp
            let height = geometry.size.height / temp
            let gridItemSize = min(width, height * aspectRatio)
            
            LazyVGrid(columns: Array(repeating: GridItem(.fixed(gridItemSize), spacing: 0), count: 4), spacing: 0) {
                ForEach(items.indices, id: \.self) { index in
                    // Use index to access item ensuring we stay within bounds
                    if index < items.count {
                        content(items[index])
                            .frame(width: gridItemSize, height: gridItemSize)
                            .aspectRatio(aspectRatio, contentMode: .fit)
                    }
                }
            }
            .frame(width: geometry.size.width, height: geometry.size.height) // Use the full available space
        }
    }
}

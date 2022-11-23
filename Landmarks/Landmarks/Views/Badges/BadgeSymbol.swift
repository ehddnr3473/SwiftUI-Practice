//
//  BadgeSymbol.swift
//  Landmarks
//
//  Created by 김동욱 on 2022/11/23.
//

import SwiftUI

struct BadgeSymbol: View {
    static let symbolColor = Color(red: 79.0 / 255, green: 79.0 / 255, blue: 191.0 / 255)
    
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                let width = min(geometry.size.width, geometry.size.height)
                let height = width * 0.75
                let spacing = width * 0.030
                let middle = width * 0.5
                let topWidth = width * 0.226
                let topHeight = height * 0.488
                
                // top portion of the symbol
                path.addLines([
                    // top edge
                    CGPoint(x: middle, y: spacing),
                    // left edge
                    CGPoint(x: middle - topWidth, y: topHeight - spacing),
                    // center edge
                    CGPoint(x: middle, y: topHeight / 2 + spacing),
                    // right edge
                    CGPoint(x: middle + topWidth, y: topHeight - spacing),
                    // top edge
                    CGPoint(x: middle, y: spacing)
                ])
                
                // bottom portion의 top edge로 이동
                path.move(to: CGPoint(x: middle, y: topHeight / 2 + spacing * 3))
                // bottom portion of the symbol
                path.addLines([
                    // 반시계 방향으로 이동하며 edge 하나씩 연결하며 drawing
                    CGPoint(x: middle - topWidth, y: topHeight + spacing),
                    CGPoint(x: spacing, y: height - spacing),
                    CGPoint(x: width - spacing, y: height - spacing),
                    CGPoint(x: middle + topWidth, y: topHeight + spacing),
                    CGPoint(x: middle, y: topHeight / 2 + spacing * 3)
                ])
            }
            .fill(Self.symbolColor)
        }
    }
}

struct BadgeSymbol_Previews: PreviewProvider {
    static var previews: some View {
        BadgeSymbol()
    }
}

//
//  Swag.swift
//  task8
//
//  Created by mi11ion on 21/12/24.
//

import SwiftUI

struct Swag: View {
    @Binding var value: Double
    @State private var drag = (start: CGFloat?.none, overdrag: CGFloat?.none, stretch: CGFloat.zero)

    var body: some View {
        RoundedRectangle(cornerRadius: 50)
            .fill(.ultraThinMaterial)
            .overlay(Rectangle().fill(.clear)
                .overlay(Rectangle().fill(.white)
                    .frame(height: value >= 1 && drag.stretch < 0 ? 350 + abs(drag.stretch) : 350 * value), alignment: .bottom)
                .clipShape(RoundedRectangle(cornerRadius: 50)))
            .frame(width: 140 * (1 - abs(drag.stretch) / 700), height: 350 + abs(drag.stretch))
            .offset(y: drag.stretch)
            .gesture(
                DragGesture()
                    .onChanged { g in
                        if drag.start == nil { drag.start = g.location.y }

                        if drag.overdrag == nil {
                            let delta = g.location.y - drag.start!
                            value = max(0, min(1, value - delta / 350))
                            if (value == 0 && delta > 0) || (value == 1 && delta < 0) { drag.overdrag = g.location.y }
                        } else {
                            let dist = g.location.y - drag.overdrag!
                            drag.stretch = dist * 0.08
                            if (value == 0 && dist < 0) || (value == 1 && dist > 0) { drag.overdrag = nil }
                        }
                        drag.start = g.location.y
                    }
                    .onEnded { _ in withAnimation(.interpolatingSpring) { drag = (nil, nil, 0) } }
            )
    }
}

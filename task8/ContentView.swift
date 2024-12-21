//
//  ContentView.swift
//  task8
//
//  Created by mi11ion on 21/12/24.
//

import SwiftUI

struct ContentView: View {
    @State private var volume: Double = 0.2

    var body: some View {
        ZStack {
            Image("swag")
                .resizable()
                .blur(radius: 10, opaque: true)
                .ignoresSafeArea()

            Swag(value: $volume)
                .frame(width: 140, height: 550)
                .clipped()
        }
    }
}

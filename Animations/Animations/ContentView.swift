//
//  ContentView.swift
//  Animations
//
//  Created by Cédric Bahirwe on 09/06/2023.
//

import SwiftUI

struct ContentView: View {
    private static let defaultCircles = 3
    private static let maxCircles = 50
    private let radius: CGFloat = 150
    @State private var numberOfCircles = defaultCircles
    
    @State private var isincreasing = true
    
    let timer = Timer.publish(every: 0.1, on: .main, in: .common)
        .autoconnect()

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            ZStack {
                ForEach(0..<numberOfCircles, id: \.self) { index in
                    Circle()
                        .stroke(lineWidth: 0.5)
                        .offset(circleOffset(at: index))
                        .foregroundColor(randomColor())
                    
                }
            }
            .frame(width: radius, height: radius)
            .onReceive(timer) { _ in
                withAnimation(.spring()) {
                    if isincreasing {
                        increasing()
                    } else {
                        decreasing()
                    }
                }
            }
        }
    }
    
    func increasing() {
        numberOfCircles += 1
        if numberOfCircles == Self.maxCircles {
            isincreasing = false
        }
    }
    
    func decreasing() {
        numberOfCircles -= 1
        if numberOfCircles == Self.defaultCircles {
            isincreasing = true
        }
    }
    
    func circleOffset(at index: Int) -> CGSize {
        let angle = 2 * .pi * Double(index) / Double(numberOfCircles)
        let x = radius/2 * CGFloat(cos(angle))
        let y = radius/2 * CGFloat(sin(angle))
        return CGSize(width: x, height: y)
    }
    
    func randomColor() -> Color {
        let red = Double.random(in: 0...1)
        let green = Double.random(in: 0...1)
        let blue = Double.random(in: 0...1)
        return Color(red: red, green: green, blue: blue)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

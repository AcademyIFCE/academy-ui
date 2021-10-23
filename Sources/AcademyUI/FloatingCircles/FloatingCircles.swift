//
//  FloatingCirclesView.swift
//  FloatingCirclesView
//
//  Created by Alley Pereira on 23/10/21.
//

import SwiftUI

@available(iOS 14.0, *)
public struct FloatingCirclesView: View {
    // MARK: - PROPERTIES

    @State private var randomCircle = Int.random(in: 10...15)
    @State private var isAnimating: Bool = false

    let foregroundColor: Color

    // MARK: - Functions

    // 1. RANDOM COORDINATE
    func randomCoordinate(max: CGFloat) -> CGFloat {
        return CGFloat.random(in: 0...max)
    }

    // 2. RANDOM SIZE
    func randomSize() -> CGFloat {
        return CGFloat(Int.random(in: 10...200))
    }
    // 3. RANDOM SCALE
    func randomScale() -> CGFloat {
        return CGFloat(Double.random(in: 0.1...2.0))
    }

    // 4. RANDOM SPEED
    func randomSpeed() -> Double {
        return Double.random(in: 0.020...1.0)
    }

    // 5. RANDOM DELAY
    func randomDelay() -> Double {
        return Double.random(in: 0...2)
    }


    // MARK: - BODY
    public var body: some View {
        GeometryReader { geometry in
            ZStack {
                ForEach(0...randomCircle, id: \.self) { item in
                    Circle()
                        .foregroundColor(foregroundColor)
                        .opacity(0.15)
                        .frame(width: randomSize(),
                               height: randomSize(),
                               alignment: .center)
                        .scaleEffect(isAnimating ? randomScale() : 1)
                        .position(x: randomCoordinate(max: geometry.size.width),
                                  y: randomCoordinate(max: geometry.size.height)
                        )
                        .animation(
                            Animation.interpolatingSpring(
                            stiffness: 0.5, damping: 0.5)
                                    .repeatForever()
                                .speed(randomSpeed())
                                .delay(randomDelay())
                        )
                        .onAppear {
                            isAnimating = true
                        }
                } //: ForEach
            } //: ZStack
            .drawingGroup()
        } //: Geometry
        .background(Color.black).ignoresSafeArea()
    }
}

// MARK: - PREVIEW
@available(iOS 14.0, *)
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        FloatingCirclesView(foregroundColor: .green)
    }
}

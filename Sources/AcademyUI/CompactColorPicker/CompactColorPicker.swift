//
//  SwiftUIView.swift
//  
//
//  Created by Mateus Rodrigues on 24/05/21.
//

import SwiftUI

public struct CompactColorPicker: View {
    
    @Binding var selection: Color
    
    let colors: [Color] = [.gray, .blue, .green, .purple, .pink, .red, .orange, .yellow]
    
    public var body: some View {
        HStack {
            ForEach(colors, id: \.self) {
                circle(color: $0)
            }
        }
    }
    
    private func circle(color: Color) -> some View {
        Circle()
            .frame(width: 25, height: 25)
            .overlay(
                Group {
                    if selection == color {
                        Circle()
                            .strokeBorder(lineWidth: 2)
                            .frame(width: 35, height: 35)
                            .transition(.scale)
                    }
                }
            )
            .foregroundColor(color)
            .onTapGesture {
                selection = color
            }
    }
    
}

struct SampleCompactColorPicker: View {
    
    @State private var selectedColor = Color.red
    
    var body: some View {
        CompactColorPicker(selection: $selectedColor)
            .padding()
            .animation(.default)
    }
    
}

struct CompactColorPicker_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            ForEach(ColorScheme.allCases, id: \.self) {
                SampleCompactColorPicker()
                    .preferredColorScheme($0)
            }
        }
        .previewLayout(.sizeThatFits)
    }
    
}

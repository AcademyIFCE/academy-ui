//
//  GalleryAnimated.swift
//  
//
//  Created by Alley Pereira on 23/10/21.
//

import SwiftUI

@available(iOS 14.0, *)
public struct GalleryAnimatedView: View {

    // MARK: - PROPERTIES
    let images: [(id: Int, image: Image)]
    let haptics = UIImpactFeedbackGenerator(style: .medium)
    let imageBorderColor: Color
    let minColumnAmount: Int
    let maxColumnAmount: Int

    @State private var gridLayout: [GridItem] = [GridItem(.flexible())]
    @State private var gridColumn: Double = 3.0
    @State private var selectedImage: Image
    @State private var numberOfImages: Int

    init(images: [(id: Int, image: Image)], borderColor: Color, minColumnAmount: Int, maxColumnAmount: Int) {
        self.images = images
        self.numberOfImages = images.count
        self.selectedImage = images.first!.image
        self.imageBorderColor = borderColor
        self.minColumnAmount = minColumnAmount
        self.maxColumnAmount = maxColumnAmount
    }

    // MARK: - Functions
    func gridSwitch() {
        gridLayout = Array(repeating: .init(.flexible()), count: (minColumnAmount + maxColumnAmount) - Int(gridColumn))
    }

    // MARK: - BODY
    public var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(alignment: .center, spacing: 30) {

                // MARK: - Selected Image
                selectedImage
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
                    .overlay(Circle().stroke(imageBorderColor, lineWidth: 10))

                // MARK: - Stepper
                Stepper("Image size", value: $gridColumn, in: Double(minColumnAmount)...Double(maxColumnAmount), step: 1)
                    .onChange(of: gridColumn) { newValue in
                        gridSwitch()
                    }

                // MARK: - Grid
                LazyVGrid(columns: gridLayout, alignment: .center, spacing: 15) {
                    ForEach(images, id: \.id) { (id, image) in
                        image
                            .resizable()
                            .scaledToFit()
                            .clipShape(Circle())
                            .overlay(Circle().stroke(imageBorderColor, lineWidth: 5))
                            .onTapGesture {
                                selectedImage = image
                                haptics.impactOccurred()
                            } //: Gesture
                    } //: ForEach
                } //: LazyVGrid
                .animation(.easeIn)
                .onAppear {
                    gridSwitch()
                }
            } //: VStack
            .padding(.horizontal, 10)
            .padding(.vertical, 50)
        } //: ScrollView
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

// MARK: - PREVIEW
@available(iOS 14.0, *)
struct GalleryAnimated_Previews: PreviewProvider {
    static var previews: some View {
        GalleryAnimatedView(
            images: [
                (id: 0, image: Image(systemName: "x.circle.fill")),
                (id: 1, image: Image(systemName: "minus.circle.fill")),
                (id: 2, image: Image(systemName: "plus.circle.fill")),
                (id: 3, image: Image(systemName: "divide.circle.fill")),
                (id: 4, image: Image(systemName: "equal.circle.fill")),
                (id: 5, image: Image(systemName: "arrowtriangle.right.circle.fill")),
                (id: 6, image: Image(systemName: "l.circle.fill")),
                (id: 7, image: Image(systemName: "a.circle.fill")),
            ],
            borderColor: Color.orange,
            minColumnAmount: 2,
            maxColumnAmount: 4
        )
    }
}

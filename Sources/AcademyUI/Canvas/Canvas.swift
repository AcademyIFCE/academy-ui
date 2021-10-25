//
//  Canvas.swift
//  
//
//  Created by Mateus Rodrigues on 24/10/21.
//

#if canImport(UIKit)

import SwiftUI
import UIKit
import PencilKit

@available(iOS 14.0, *)
struct Canvas: UIViewRepresentable {
    
    class Coordinator: NSObject, PKCanvasViewDelegate {
        
        var parent: Canvas
        
        init(_ parent: Canvas) {
            self.parent = parent
        }
        
        func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
            parent.drawing = canvasView.drawing
        }
        
        func scrollViewDidZoom(_ scrollView: UIScrollView) {
            parent.zoomScale = scrollView.zoomScale
            let offsetX = max((scrollView.bounds.width - scrollView.contentSize.width) * 0.5, 0)
            let offsetY = max((scrollView.bounds.height - scrollView.contentSize.height) * 0.5, 0)
            scrollView.contentInset = UIEdgeInsets(top: offsetY, left: offsetX, bottom: 0, right: 0)
            parent.contentOffset = scrollView.contentOffset
        }
        
    }
    
    @Binding var drawing: PKDrawing
    @Binding var zoomScale: CGFloat
    var minimumZoomScale: CGFloat = 0.25
    var maximumZoomScale: CGFloat = 4.00
    @Binding var contentOffset: CGPoint
    
    var toolPicker: PKToolPicker
    
    var isFirstResponder: Bool
    
    func makeUIView(context: Context) -> PKCanvasView {
        let view = PKCanvasView()
        view.tool = toolPicker.selectedTool
        view.isOpaque = false
        view.backgroundColor = .clear
        view.delegate = context.coordinator
        view.minimumZoomScale = minimumZoomScale
        view.maximumZoomScale = maximumZoomScale
        view.bouncesZoom = false
        toolPicker.setVisible(true, forFirstResponder: view)
        toolPicker.addObserver(view)
        return view
    }
    
    func updateUIView(_ uiView: PKCanvasView, context: Context) {
        uiView.setZoomScale(zoomScale, animated: false)
        uiView.setContentOffset(contentOffset, animated: false)
        if isFirstResponder {
            uiView.becomeFirstResponder()
            uiView.isUserInteractionEnabled = true
        } else {
            uiView.resignFirstResponder()
            uiView.isUserInteractionEnabled = false
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
}

// MARK: - PREVIEW
@available(iOS 14.0, *)
struct Canvas_Previews: PreviewProvider {
    static var previews: some View {
        Canvas(
            drawing: .constant(PKDrawing()),
            zoomScale: .constant(1),
            contentOffset: .constant(.zero),
            toolPicker: PKToolPicker(),
            isFirstResponder: true
        )
    }
}


#endif


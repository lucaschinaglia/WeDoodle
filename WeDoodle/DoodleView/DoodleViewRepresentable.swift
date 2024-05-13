//
//  DoodleViewRepresentable.swift
//  WeDoodle
//
//  Created by Lucas Chinaglia de Oliveira on 26/04/24.
//

import Foundation
import Combine
import SwiftUI

struct DoodleViewRepresentable: UIViewRepresentable {
    @ObservedObject var viewModel: DoodleViewModel
    @Binding var doodle: Doodle

    init(viewModel: DoodleViewModel, doodle: Binding<Doodle>) {
        self._viewModel = ObservedObject(wrappedValue: viewModel)
        self._doodle = doodle
    }
    
    func makeUIView(context: Context) -> DoodleView {
        let doodleView = DoodleView()
        doodleView.viewModel = viewModel
        // Load the drawing if imageData is present.
        if let imageData = doodle.imageData {
            doodleView.loadDrawing(data: imageData)
        }
        return doodleView
    }

    func updateUIView(_ uiView: DoodleView, context: Context) {
        // Update the view with the latest viewModel data
        if let imageData = viewModel.currentDoodle?.imageData {
            let image = UIImage(data: imageData)
            uiView.image = image // Assuming your DoodleView can display a UIImage directly
        }
    }
    
    func getDoodleView() -> DoodleView {
        // You need to find a way to reference the actual DoodleView that's being used.
        // This is just a placeholder to represent the logic of obtaining the DoodleView.
        return DoodleView()
    }

    func createThumbnail() -> UIImage? {
        let doodleView = getDoodleView()
        let renderer = UIGraphicsImageRenderer(bounds: doodleView.bounds)
        let image = renderer.image { _ in
            doodleView.drawHierarchy(in: doodleView.bounds, afterScreenUpdates: true)
        }
        return image
    }
    
    func loadDrawing(doodle: Doodle) {
        guard let imageData = doodle.imageData else { return }
        let image = UIImage(data: imageData)
        // Here you would need a way to get the actual 'uiView' instance and set the image
        // This part is tricky because UIViewRepresentable doesn't directly manage the views in the same way
    }
}

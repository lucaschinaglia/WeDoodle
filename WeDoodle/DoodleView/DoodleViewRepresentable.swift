//
//  DoodleViewRepresentable.swift
//  WeDoodle
//
//  Created by Lucas Chinaglia de Oliveira on 26/04/24.
//

import Foundation

import SwiftUI

struct DoodleViewRepresentable: UIViewRepresentable {
    @ObservedObject var viewModel: DoodleViewModel

    func makeUIView(context: Context) -> DoodleView {
        let doodleView = DoodleView()
        doodleView.viewModel = viewModel // Pass the viewModel here
        return doodleView
    }

    func updateUIView(_ uiView: DoodleView, context: Context) {
        if viewModel.isErasing {
            uiView.strokeColor = .white // Assuming you have a strokeColor property.
            uiView.strokeWidth = viewModel.eraserSize
        } else {
            uiView.strokeColor = viewModel.lineColor
            uiView.strokeWidth = viewModel.lineWidth
        }
        // Trigger a redraw if necessary
        uiView.setNeedsDisplay()
    }
}

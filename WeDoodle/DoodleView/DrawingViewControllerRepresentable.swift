//
//  DrawingViewControllerRepresentable.swift
//  WeDoodle
//
//  Created by Lucas Chinaglia de Oliveira on 26/04/24.
//

import Foundation

import SwiftUI

struct DrawingViewControllerRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> DrawingViewController {
        return DrawingViewController()
    }

    func updateUIViewController(_ uiViewController: DrawingViewController, context: Context) {
        // Update the view controller if needed
    }
    
    func loadDrawing(doodle: Doodle) {
        // This function should call a method on your actual DoodleView instance to load the drawing.
    }
}

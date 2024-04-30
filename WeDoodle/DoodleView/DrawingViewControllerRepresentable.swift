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
}

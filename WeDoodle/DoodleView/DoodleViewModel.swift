//
//  DoodleViewModel.swift
//  WeDoodle
//
//  Created by Lucas Chinaglia de Oliveira on 27/04/24.
//

import Foundation

import UIKit

import Combine

class DoodleViewModel: ObservableObject {
    @Published var lineColor: UIColor = .black
    @Published var lineWidth: CGFloat = 5
    @Published var eraserSize: CGFloat = 10
    @Published var isErasing: Bool = false
    
}




//
//  DoodleView.swift
//  WeDoodle
//
//  Created by Lucas Chinaglia de Oliveira on 26/04/24.
//

import Foundation
import UIKit
import Combine

class DoodleView: UIView {
    
    var image: UIImage? {
        didSet {
            // Code to handle the new image and redraw the view
        }
    }
    
    var viewModel: DoodleViewModel?
    
    // This property holds the current stroke width
    var strokeWidth: CGFloat = 5
    
    // The color of the stroke
    var strokeColor: UIColor = .black
    
    // The current path that's being drawn
    var currentPath: UIBezierPath?
    
    // Paths array holds each path along with its color and stroke width
    var paths: [(path: UIBezierPath, color: UIColor, strokeWidth: CGFloat)] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        // Set up the view with a dotted background
        setDottedBackground()
        isMultipleTouchEnabled = false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: self) else { return }
        currentPath = UIBezierPath()
        currentPath?.move(to: point)
        
        // Begin with rounded line caps and joins
        currentPath?.lineCapStyle = .round
        currentPath?.lineJoinStyle = .round
        currentPath?.lineWidth = strokeWidth
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: self),
              let currentPath = currentPath else { return }
        
        currentPath.addLine(to: point)
        setNeedsDisplay() // Requests the system to redraw the view
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let currentPath = currentPath else { return }
        
        paths.append((path: currentPath, color: strokeColor, strokeWidth: strokeWidth))
        self.currentPath = nil // Reset the current path
        setNeedsDisplay()
    }
    
    override func draw(_ rect: CGRect) {
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        for (path, color, width) in paths {
            context.saveGState()
            context.setBlendMode(.normal)
            color.setStroke()
            path.lineWidth = width
            path.lineCapStyle = .round
            path.stroke()
            context.restoreGState()
        }
        
        // Do the same for the current path if it exists
        if let currentPath = currentPath {
            context.saveGState()
            context.setBlendMode(.normal)
            strokeColor.setStroke()
            currentPath.lineWidth = strokeWidth
            currentPath.lineCapStyle = .round
            currentPath.stroke()
            context.restoreGState()
        }
    }
    
    // Call this method when you want to erase all paths
    func eraseAll() {
        paths.removeAll()
        setNeedsDisplay()
    }
    
    func createThumbnail() -> UIImage? {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { ctx in
            drawHierarchy(in: bounds, afterScreenUpdates: true)
        }
    }
    
    func loadDrawing(data: Data) {
        guard let image = UIImage(data: data) else { return }
        let imageView = UIImageView(image: image)
        imageView.frame = self.bounds
        self.addSubview(imageView)
        self.sendSubviewToBack(imageView)
    }
    
    func getImageData() -> Data? {
        UIGraphicsBeginImageContext(self.bounds.size)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        self.layer.render(in: context)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image?.pngData()
    }
}
    
    // MARK: - DoodleView Extension for Dotted Background
    extension DoodleView {
        func setDottedBackground() {
            // Increase the tile size for more spacing between dots
            let tileSize = CGSize(width: 40, height: 40)
            // Make the dot radius smaller
            let dotRadius: CGFloat = 1
            // Adjust the pattern offset if needed, or calculate it based on the tile size
            let patternOffset: CGFloat = tileSize.width / 4
            
            UIGraphicsBeginImageContextWithOptions(tileSize, false, 0)
            guard let context = UIGraphicsGetCurrentContext() else { return }
            
            // Use a lighter color for the dots
            UIColor(white: 0.85, alpha: 1).setFill()  // Adjust the white value as needed
            
            for x in stride(from: patternOffset, through: tileSize.width - patternOffset, by: tileSize.width / 2) {
                for y in stride(from: patternOffset, through: tileSize.height - patternOffset, by: tileSize.height / 2) {
                    context.fillEllipse(in: CGRect(x: x - dotRadius, y: y - dotRadius, width: dotRadius * 2, height: dotRadius * 2))
                }
            }
            
            let tileImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            if let tileImage = tileImage {
                backgroundColor = UIColor(patternImage: tileImage)
            }
        }
    }

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
    @Published var currentDoodle: Doodle?

    // Hold a weak reference to avoid a retain cycle, and it’s optional because it may not always be set
    weak var doodleView: DoodleView?
    var doodle: Doodle? // Optional, since it may not always be set

    // Initialization that takes a DoodleView
    init() {
        
    }
    // This method creates a thumbnail image from the DoodleView
    func createThumbnail() -> UIImage? {
            guard let doodleView = doodleView else {
                print("DoodleView is not set.")
                return nil
            }

            // Set the size for the thumbnail image
            let thumbnailSize = CGSize(width: 100, height: 100) // Set your desired thumbnail size
            let renderer = UIGraphicsImageRenderer(size: thumbnailSize)

            let image = renderer.image { context in
                // Begin rendering context for drawing
                context.cgContext.saveGState()

                // Adjust the scale for the thumbnail
                let scale = max(doodleView.bounds.width / thumbnailSize.width,
                                doodleView.bounds.height / thumbnailSize.height)
                context.cgContext.scaleBy(x: scale, y: scale)

                // Draw all the paths in the paths array onto the context
                for (path, color, strokeWidth) in doodleView.paths {
                    color.setStroke()
                    path.stroke()
                }

                // If there's a current path being drawn, draw it as well
                if let currentPath = doodleView.currentPath {
                    doodleView.strokeColor.setStroke()
                    currentPath.stroke()
                }

                // Restore the context state
                context.cgContext.restoreGState()
            }

            return image
        }

    func saveCurrentDrawing(completion: @escaping (Doodle) -> Void) {
        let thumbnail = createThumbnail()
        
        // Replace this with actual data if you're saving the drawing
        let imageData: Data? = nil

        let newDoodle = Doodle(title: "New Drawing", thumbnail: thumbnail, imageData: imageData)

        // Simulate an asynchronous operation, like saving to a file
        DispatchQueue.main.async {
            completion(newDoodle)
        }
    }
    
    func saveDrawingAndThumbnail() {
        print("Starting the save process...")
        if let thumbnailImage = createThumbnail() {
            print("Thumbnail created successfully.")
            if let thumbnailData = thumbnailImage.pngData() {
                print("Thumbnail data generated, saving to disk...")
                // Save the thumbnailData to disk or database
                // Use the saved file path or database ID to create the Doodle object
                // Let's assume you have a function saveDataToDisk(data:) -> String that returns a file path
                let filePath = saveDataToDisk(data: thumbnailData)
                print("Thumbnail saved at path: \(filePath)")
                
                // Now update your Doodle object with the file path
                var currentDoodle = self.doodle
                currentDoodle?.thumbnailPath = filePath // Assuming Doodle has a 'thumbnailPath' property
                print("Doodle object updated with thumbnail path.")
                
                // Don't forget to save other parts of the doodle like the actual drawing data
                print("Saving other doodle data...")
                // Add logic here to save the rest of the doodle data, if necessary.
            } else {
                print("Error: Unable to generate thumbnail data from image.")
            }
        } else {
            print("Error: Thumbnail creation failed.")
        }
        print("Save process completed.")
    }

    func loadDrawing(from doodle: Doodle) {
        print("Starting the load process for doodle titled: \(doodle.title)")
        // Assuming doodle has imageData or a file path to load the drawing
        if let imageData = doodle.imageData {
            print("Image data found, loading drawing...")
            // Load the drawing into the DoodleView
            self.doodleView?.loadDrawing(data: imageData)
            print("Drawing loaded successfully.")
        } else {
            print("Error: No image data found for doodle titled: \(doodle.title)")
        }
    }


    
    // A function to convert and save the drawing data to a persistent storage, and return the path
    private func saveDataToDisk(data: Data?) -> String {
        // Logic to save data to disk or database and return the file path or reference
        // Placeholder for your save logic
        return "path/to/saved/thumbnail.png"
    }
}

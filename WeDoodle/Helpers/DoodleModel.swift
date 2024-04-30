//
//  DoodleModel.swift
//  WeDoodle
//
//  Created by Lucas Chinaglia de Oliveira on 29/04/24.
//

import Foundation
import UIKit

struct Doodle: Identifiable, Codable {
    var id: UUID
    var title: String
    var creationDate: Date
    var lastEditedDate: Date?
    var thumbnail: UIImage?
    
    init(title: String, thumbnail: UIImage? = nil) {
        self.id = UUID() // Generates a unique identifier
        self.title = title
        self.creationDate = Date() // Sets the creation date to the current date
        self.lastEditedDate = nil // This will be set when a Doodle is edited
        self.thumbnail = thumbnail
    }
    
    // Add any additional properties or methods you need for a doodle
}

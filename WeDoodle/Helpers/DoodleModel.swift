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
    var drawingData: Data?
    var imageData: Data? // This would be the actual drawing data if you save it to a file
    var thumbnailData: Data?
    var thumbnailPath: String?
    
    init(title: String, thumbnail: UIImage? = nil, imageData: Data? = nil, thumbnailData: Data? = nil, thumbnailPath: String? = nil) {
        self.id = UUID() // Generates a unique identifier
        self.title = title
        self.creationDate = Date() // Sets the creation date to the current date
        self.lastEditedDate = nil // This will be set when a Doodle is edited
        self.thumbnail = thumbnail
        self.imageData = imageData
        self.thumbnailData = thumbnailData
        self.thumbnailPath = thumbnailPath
    }
    
    // Add any additional properties or methods you need for a doodle
}

// Extend UIImage to convert to and from Data for UserDefaults storage
extension UIImage {
    // Convert UIImage to Data
    func toData() -> Data? {
        return jpegData(compressionQuality: 1.0)
    }
    
    // Initialize UIImage from Data
    convenience init?(data: Data?) {
        guard let imageData = data else { return nil }
        self.init(data: imageData)
    }
}

extension Doodle {
    enum CodingKeys: CodingKey {
        case id, title, creationDate, lastEditedDate, thumbnailData, imageData
    }

    // Encode function
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
        try container.encode(creationDate, forKey: .creationDate)
        try container.encode(lastEditedDate, forKey: .lastEditedDate)
        // Convert UIImage to Data
        try container.encode(thumbnail?.toData(), forKey: .thumbnailData)
        try container.encode(imageData, forKey: .imageData)
    }

    // Decode function
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(UUID.self, forKey: .id)
        title = try container.decode(String.self, forKey: .title)
        creationDate = try container.decode(Date.self, forKey: .creationDate)
        lastEditedDate = try container.decode(Date?.self, forKey: .lastEditedDate)
        // Initialize UIImage from Data
        let thumbnailData = try container.decode(Data?.self, forKey: .thumbnailData)
        thumbnail = UIImage(data: thumbnailData)
        imageData = try container.decode(Data?.self, forKey: .imageData)
    }
}

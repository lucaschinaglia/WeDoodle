//
//  DoodleStorage.swift
//  WeDoodle
//
//  Created by Lucas Chinaglia de Oliveira on 29/04/24.
//

import Foundation
import UIKit

class DoodleStorage {
    private let defaults = UserDefaults.standard
    private let doodlesKey = "savedDoodles"

    // Save the current array of doodles to UserDefaults
    func saveDoodles(_ doodles: [Doodle]) {
        do {
            let data = try JSONEncoder().encode(doodles)
            defaults.set(data, forKey: doodlesKey)
        } catch {
            print("Failed to save doodles: \(error)")
        }
    }
    
    // Load the array of doodles from UserDefaults
    func loadDoodles() -> [Doodle] {
        guard let data = defaults.data(forKey: doodlesKey) else { return [] }
        do {
            return try JSONDecoder().decode([Doodle].self, from: data)
        } catch {
            print("Failed to load doodles: \(error)")
            return []
        }
    }
}

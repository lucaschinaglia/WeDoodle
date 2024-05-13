//
//  DoodleHomeView.swift
//  WeDoodle
//
//  Created by Lucas Chinaglia de Oliveira on 29/04/24.
//

import Foundation
import SwiftUI

struct DoodleHomeView: View {
    @State private var doodles: [Doodle] = []
    @State private var navigatingToNewDoodle = false

    var body: some View {
        NavigationView {
            List {
                ForEach(doodles) { doodle in
                    NavigationLink(destination: ContentView(doodle: doodle, onSave: saveDoodle)) {
                        DoodleRow(doodle: doodle)
                    }
                }
                NavigationLink(destination: ContentView(doodle: Doodle(title: "New Doodle"), onSave: saveDoodle), isActive: $navigatingToNewDoodle) {
                    EmptyView()
                }
            }
            .navigationBarTitle("My Doodles")
            .navigationBarItems(trailing: Button(action: {
                self.navigatingToNewDoodle = true
                // Reset any doodle details if necessary before creating a new one
            }) {
                Image(systemName: "plus")
            })
            .onAppear(perform: loadDoodles)
        }
    }

    private func loadDoodles() {
        let storedDoodles = DoodleStorage().loadDoodles()
        doodles = storedDoodles
    }

    private func saveDoodle(doodle: Doodle) {
        if let index = doodles.firstIndex(where: { $0.id == doodle.id }) {
            // Update the existing doodle
            doodles[index] = doodle
        } else {
            // Add a new doodle
            doodles.append(doodle)
        }
        // Persist the changes
        DoodleStorage().saveDoodles(doodles)
    }
}

struct DoodleHomeView_Previews: PreviewProvider {
    static var previews: some View {
        DoodleHomeView()
    }
}

struct DoodleRow: View {
    var doodle: Doodle

    var body: some View {
        HStack {
            Image(systemName: "photo.on.rectangle.angled")
                .resizable()
                .frame(width: 50, height: 50)
                .cornerRadius(8)

            VStack(alignment: .leading) {
                Text(doodle.title)
                    .font(.headline)
                // Add more details if needed
            }
        }
    }
}

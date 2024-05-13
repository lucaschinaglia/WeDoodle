//
//  ContentView.swift
//  WeDoodle
//
//  Created by Lucas Chinaglia de Oliveira on 26/04/24.
//

import SwiftUI
import Combine

struct ContentView: View {
    @StateObject private var viewModel = DoodleViewModel()
    @State private var showingColorPicker = false
    @State private var selectedColor = Color.black
    @State private var doodle: Doodle
    var onSave: (Doodle) -> Void
    private var doodleViewRepresentable: DoodleViewRepresentable
    
    init(doodle: Doodle, onSave: @escaping (Doodle) -> Void) {
        _doodle = State(initialValue: doodle)
        self.onSave = onSave
        _viewModel = StateObject(wrappedValue: DoodleViewModel())
        // Initialize doodleViewRepresentable with the appropriate viewModel and doodle
        doodleViewRepresentable = DoodleViewRepresentable(viewModel: _viewModel.wrappedValue, doodle: Binding.constant(_doodle.wrappedValue))
    }

    var body: some View {
        DoodleViewRepresentable(viewModel: viewModel, doodle: $doodle)
            .navigationBarTitle(doodle.title, displayMode: .inline)
            .navigationBarItems(
                leading: Button(action: {
                    self.saveDrawing()
                    self.onSave(self.doodle)
                }) {
                    Image(systemName: "arrow.left")
                },
                trailing: Button(action: {
                    self.showingColorPicker.toggle()
                }) {
                    Image(systemName: "circle.fill").foregroundColor(selectedColor)
                }
            )
            .sheet(isPresented: $showingColorPicker) {
                ColorPicker("Pick a color", selection: $selectedColor, supportsOpacity: false)
                    .onChange(of: selectedColor) { newValue in
                        viewModel.lineColor = UIColor(newValue)
                        viewModel.lineWidth = viewModel.lineWidth
                    }
                    .padding()
            }
            .onAppear {
                print("ContentView appeared.")
                if let doodle = viewModel.doodle {
                    print("Doodle found, loading drawing... Title: \(doodle.title)")
                    viewModel.currentDoodle = doodle
                } else {
                    print("No doodle found to load. Creating a new one.")
                    let newDoodle = Doodle(title: "New Doodle", thumbnail: nil, imageData: nil)
                    viewModel.doodle = newDoodle
                    viewModel.currentDoodle = newDoodle
                }
            }
            .onDisappear {
                print("ContentView is disappearing. Attempting to save...")
                self.saveDrawing()
            }
    }
    
    func saveDrawing() {
        if let doodleView = viewModel.doodleView {
            let imageData = doodleView.getImageData()
            doodle.imageData = imageData
            let thumbnail = doodleView.createThumbnail()
            doodle.thumbnail = thumbnail
            self.onSave(doodle)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(doodle: Doodle(title: "Preview Doodle", thumbnail: UIImage(), imageData: Data()), onSave: { _ in
            // This is a mock closure for previews, so it doesn't need to do anything.
        })
    }
}

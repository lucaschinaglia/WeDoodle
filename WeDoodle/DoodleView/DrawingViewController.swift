//
//  DrawingViewController.swift
//  WeDoodle
//
//  Created by Lucas Chinaglia de Oliveira on 26/04/24.
//

import Foundation
import UIKit

class DrawingViewController: UIViewController {
    var doodleView: DoodleView!
    var toolbar: UIToolbar!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Initialize the doodle view
        doodleView = DoodleView()
        doodleView.backgroundColor = .white // Set a background color for the doodle view
        doodleView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(doodleView)

        // Initialize the toolbar
        toolbar = UIToolbar()
        toolbar.translatesAutoresizingMaskIntoConstraints = false
        toolbar.backgroundColor = .gray // Set a background color for the toolbar for visibility
        view.addSubview(toolbar)

        // Setup Auto Layout constraints
        setupConstraints()

        // Setup toolbar items
        setupToolbarItems()
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            doodleView.topAnchor.constraint(equalTo: view.topAnchor),
            doodleView.bottomAnchor.constraint(equalTo: toolbar.topAnchor),
            doodleView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            doodleView.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            toolbar.heightAnchor.constraint(equalToConstant: 44),
            toolbar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            toolbar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            toolbar.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }

    func setupToolbarItems() {
        let eraserButton = UIBarButtonItem(title: "Eraser", style: .plain, target: self, action: #selector(eraserTapped))
        let redButton = UIBarButtonItem(title: "Red", style: .plain, target: self, action: #selector(colorTapped(_:)))
        redButton.tintColor = .red
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([eraserButton, flexibleSpace, redButton], animated: false)
    }

    @objc func eraserTapped() {
        // Eraser logic
    }

    @objc func colorTapped(_ sender: UIBarButtonItem) {
        // Color change logic
    }
}

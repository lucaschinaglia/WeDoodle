//
//  DottedBackgroundView.swift
//  WeDoodle
//
//  Created by Lucas Chinaglia de Oliveira on 13/05/24.
//

import UIKit

class DottedBackgroundView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        backgroundColor = UIColor.clear
    }

    override func draw(_ rect: CGRect) {
        let tileSize = CGSize(width: 40, height: 40)
        let dotRadius: CGFloat = 1
        let patternOffset: CGFloat = tileSize.width / 4

        guard let context = UIGraphicsGetCurrentContext() else { return }

        UIColor(white: 0.85, alpha: 1).setFill()

        for x in stride(from: patternOffset, through: bounds.width, by: tileSize.width / 2) {
            for y in stride(from: patternOffset, through: bounds.height, by: tileSize.height / 2) {
                context.fillEllipse(in: CGRect(x: x - dotRadius, y: y - dotRadius, width: dotRadius * 2, height: dotRadius * 2))
            }
        }
    }
}

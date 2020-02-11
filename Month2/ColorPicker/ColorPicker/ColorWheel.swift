//
//  ColorWheel.swift
//  ColorPicker
//
//  Created by Ufuk Türközü on 23.01.20.
//  Copyright © 2020 Ufuk Türközü. All rights reserved.
//

import UIKit

class ColorWheel: UIView {

    // MARK: - Properties
    
    var color: UIColor = .white
    var brightness: CGFloat = 0.8 {
        didSet{
            setNeedsDisplay()
        }
    }
    
    // MARK: - View Lifecycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        isUserInteractionEnabled = false
        
        clipsToBounds = true
        //let radius = frame.width / 2
        layer.cornerRadius = frame.width / 2
        layer.borderWidth = 1
        layer.borderColor = UIColor.black.cgColor
    }
    
    override func draw(_ rect: CGRect) {
        // Drawing code
        let size: CGFloat = 1
        
        for y in stride(from: 0, to: bounds.maxY, by: size) {
            for x in stride(from: 0, to: bounds.maxX, by:size) {
                let color = self.color(for: CGPoint(x: x, y: y))
                let pixel = CGRect(x: x, y: y, width: size, height: size)
                
                color.set()
                UIRectFill(pixel)
            }
        }
    }
    
    func color(for location: CGPoint) -> UIColor {
        let center = CGPoint(x: bounds.minX, y: bounds.minY)
        let dy = location.y - center.y
        let dx = location.x - center.x
        let offset = CGPoint(x: dx/center.x, y: dy/center.y)
        //let data = Color.getHueSaturation(at: offset)
        let (hue, saturation) = Color.getHueSaturation(at: offset)
        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1)
        
    }
    
    
}

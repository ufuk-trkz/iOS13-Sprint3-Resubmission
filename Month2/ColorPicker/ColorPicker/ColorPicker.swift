//
//  ColorPicker.swift
//  ColorPicker
//
//  Created by Ufuk Türközü on 23.01.20.
//  Copyright © 2020 Ufuk Türközü. All rights reserved.
//

import UIKit


@IBDesignable class ColorPicker: UIControl {

   // MARK: - Properties
    
    var color: UIColor = .white
    var colorWheel = ColorWheel()
    var brightnessSlider = UISlider()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpSubViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpSubViews()
    }
    
    private func setUpSubViews() {
        backgroundColor = .clear
        
        // Color Wheel
        colorWheel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(colorWheel)
        
        NSLayoutConstraint.activate([
            colorWheel.topAnchor.constraint(equalTo: topAnchor),
            colorWheel.leadingAnchor.constraint(equalTo: leadingAnchor),
            colorWheel.trailingAnchor.constraint(equalTo: trailingAnchor),
            colorWheel.heightAnchor.constraint(equalTo: colorWheel.widthAnchor)
        ])
        
        // Brightness Slider
        brightnessSlider.minimumValue = 0
        brightnessSlider.maximumValue = 1
        brightnessSlider.value = 0.8
        brightnessSlider.translatesAutoresizingMaskIntoConstraints = false
        brightnessSlider.addTarget(self, action: #selector(changeBrightness), for: .valueChanged)
        addSubview(brightnessSlider)
        
            NSLayoutConstraint.activate([
                brightnessSlider.topAnchor.constraint(equalTo: colorWheel.bottomAnchor, constant: 8),
                brightnessSlider.leadingAnchor.constraint(equalTo: leadingAnchor),
                brightnessSlider.trailingAnchor.constraint(equalTo: trailingAnchor)
            ])
    }
    
    @objc func changeBrightness() {
        colorWheel.brightness = CGFloat(brightnessSlider.value)
    }
    
    // MARK: - Touch Tracking
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let touchPoint = touch.location(in: self)
        color = colorWheel.color(for: touchPoint)
        sendActions(for: [.touchDown, .valueChanged])
        return true
    }
    
    override func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        let touchPoint = touch.location(in: self)
        color = colorWheel.color(for: touchPoint)
        if bounds.contains(touchPoint) {
            color = colorWheel.color(for: touchPoint)
            sendActions(for: [.touchDragInside, .valueChanged])
        } else {
            sendActions(for: [.touchDragOutside])
        }
        return true
    }
    
    override func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        defer { super.endTracking(touch, with: event)}
        
        guard let touch = touch else { return }
        
        let touchPoint = touch.location(in: self)
        
        if bounds.contains(touchPoint) {
            color = colorWheel.color(for: touchPoint)
            sendActions(for: [.touchUpInside, .valueChanged])
        } else {
            sendActions(for: [.touchUpOutside])
        }
    }
    
    override func cancelTracking(with event: UIEvent?) {
        sendActions(for: [.touchCancel])
    }
}

//
//  Color.swift
//  ColorPicker
//
//  Created by Ufuk Türközü on 23.01.20.
//  Copyright © 2020 Ufuk Türközü. All rights reserved.
//

import UIKit

// A utility Color type
struct Color {
    static func getHueSaturation(at offset: CGPoint) -> (hue: CGFloat, saturation: CGFloat) {
        if offset == CGPoint.zero {
            return (hue: 0, saturation: 0)
        } else {
            // The further away from the center you are, the ore saturated the color
            let saturation = sqrt(offset.x * offset.x + offset.y * offset.y)
            // The offset ngle is determined to figure out what hue to use within the full spectrum
            var hue = acos(offset.x / saturation) / (2 * CGFloat.pi)
            if offset.y < 0 { hue = 1 - hue }
            return(hue: hue, saturation: saturation)
        }
        
        
    }
}

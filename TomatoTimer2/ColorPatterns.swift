//
//  ColorPatterns.swift
//  TomatoTimer2
//
//  Created by jonah wilmsmeyer on 2020-07-05.
//  Copyright © 2020 jonah wilmsmeyer. All rights reserved.
//
import UIKit
class ColorPattern{
    var backgrounColor: UIColor
    var mainTextColor: UIColor
    var subTextColor: UIColor
    
    private init(_ backgroundColor: UIColor, _ mainTextColor: UIColor, _ subTextColor: UIColor) {
        self.backgrounColor = backgroundColor
        self.mainTextColor = mainTextColor
        self.subTextColor = subTextColor
    }
        
    static let defaultColorPaterns = [ColorPattern(.white, .black,.gray)]
    static func getColor(_ type: String) -> ColorPattern {
        
        switch type {
        case "light":
            return ColorPattern.defaultColorPaterns[0]
        default:
            return ColorPattern.defaultColorPaterns[0]
        }
    }
}

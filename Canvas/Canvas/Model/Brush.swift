//
//  Brush.swift
//  Canvas
//
//  Created by angel zambrano on 8/29/21.
//

import Foundation
import UIKit

class Brush {
    var nameOfBrush: String
    var lengthOfBrush: Float
    var color: UIColor
    var radius: Double
    
    init(nameOfBrush: String,lengthOfBrush: Float,color: UIColor, radius: Double){
        self.nameOfBrush = nameOfBrush
        self.lengthOfBrush = lengthOfBrush
        self.color = color
        self.radius = radius
    }
}

struct Constants {
    static let buttonHeight = 60
    static let buttonWidth = 60
}

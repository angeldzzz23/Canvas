//
//  Canvas.swift
//  Canvas
//
//  Created by angel zambrano on 8/31/21.


import Foundation
import UIKit

class Canvas: UIView  {

    var StroColor = UIColor.red.cgColor
    var lines = [[CGPoint]]()
    var lineWidth: CGFloat = 5
    
    // undos last line
    func undo() {
        _ = lines.popLast()
        setNeedsDisplay()
    }
    
    func setWidth(width: CGFloat) {
        lineWidth = width
    }
    
    
    // clears the entire screen
    func clean() {
        lines.removeAll()
        setNeedsDisplay()
    }
    
    override func draw(_ rect: CGRect) {
        // custom drawing
        super.draw(rect)
        
        
        
        guard let context = UIGraphicsGetCurrentContext() else { return }
        
        context.setStrokeColor(StroColor)
        context.setLineWidth(lineWidth)
        context.setLineCap(.butt)
    
        lines.forEach { (line) in
            for (i, p) in line.enumerated() {
                if i == 0 {
                    context.move(to: p)
                } else {
                    context.addLine(to: p)
                }
            }
        }
        
        
        context.strokePath()
    }
    
    

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lines.append([CGPoint]())
    }
    
    // track the fingers as we move across screen
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: nil) else {return }
        
        guard var lastLine = lines.popLast() else {return}
        lastLine.append(point)
        
        lines.append(lastLine)
        
        setNeedsDisplay() // redraws
    }
}

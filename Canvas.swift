//
//  Canvas.swift
//  drawingApp
//
//  Created by Arun Aravindakshan on 12/01/19.
//  Copyright © 2019 Jefin. All rights reserved.
//

import UIKit

class Canvas:UIView{
    //public function
    func undo() {
      _ = lines.popLast()
        setNeedsDisplay()
    }
    func clear () {
        lines.removeAll()
        setNeedsDisplay()
    }
    var lines = [[CGPoint]]()
    override func draw(_ rect: CGRect) {
        //custom drawing
        super.draw(rect)
        
        guard let context = UIGraphicsGetCurrentContext() else {return}
        
        // my lines
        //        let startPoint = CGPoint(x: 0, y: 0)
        //        let endPoint = CGPoint(x: 100, y: 100)
        //        context.move(to: startPoint)
        //        context.addLine(to: endPoint)
        // line.forEach{(p) in}
        context.setStrokeColor(UIColor.red.cgColor)
        context.setLineWidth(10)
        context.setLineCap(.butt)
        
        lines.forEach{(line) in
            for(i,p) in line.enumerated(){
                if i == 0 {
                    context.move(to: p)
                } else {
                    context.addLine(to: p)
                }
            }
        }
        //        for(i,p) in line.enumerated(){
        //            if i == 0 {
        //                context.move(to: p)
        //            } else {
        //                context.addLine(to: p)
        //            }
        //        }
        context.strokePath()
    }
    // var line = [CGPoint]()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lines.append([CGPoint]())
    }
    
    //track the finger across the screen
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let point = touches.first?.location(in: nil) else {return}
        guard var lastLine = lines.popLast() else {return}
        lastLine.append(point)
        lines.append(lastLine)
        //        var lastLine = lines.last
        //        lastLine?.append(point)
        setNeedsDisplay()
    }
}

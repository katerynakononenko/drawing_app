//
//  drawLine.swift
//  lab3
//
//  Created by Kateryna Kononenko on 2/9/17.
//  Copyright © 2017 Kateryna Kononenko. All rights reserved.
//

import UIKit


class DrawLine: UIView {
    var firstPoint: CGPoint?
    var newArray : [CGPoint] = [] {
        didSet{
            setNeedsDisplay()
        }
    }
    var path = UIBezierPath()
    var mid : CGPoint
   
    var color : UIColor = .black
    var lineWidth: CGFloat = 4
    
  var theLine:Line?{
     didSet{
         setNeedsDisplay()
        }
   }
    
    
    override init(frame: CGRect){
        mid = CGPoint(x:0,y:0)
        super.init(frame : frame)
      backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

    
    private func midpoint(first: CGPoint, second: CGPoint) -> CGPoint {
        // implement this function here 
        mid = CGPoint (x: ((second.x + first.x)/2), y: ((second.y + first.y)/2))
        return mid
    }
    
    func createQuadPath(points: [CGPoint]) -> UIBezierPath {
        let path = UIBezierPath()
        if points.count < 2 { return path }
        let firstPoint = points[0]
        let secondPoint = points[1]
        let firstMidpoint = midpoint(first: firstPoint, second: secondPoint)
        path.move(to: firstPoint)
        path.addLine(to: firstMidpoint)
        for index in 1 ..< points.count-1 {
            let currentPoint = points[index]
            let nextPoint = points[index + 1]
            let midPoint = midpoint(first: currentPoint, second: nextPoint)
            path.addQuadCurve(to: midPoint, controlPoint: currentPoint)
        }
        guard let lastLocation = points.last else { return path }
        path.addLine(to: lastLocation)
        return path
    }
 
   
    

    override func draw(_ rect: CGRect) {
      //print ("before hello")
        
   // let point1 = newLine.firstp
     //   var point2 = newLine.changingp
       // point2.insert(firstPoint!, at: 0)
       // newArray.insert(firstPoint!, at: 0)
        
        path = createQuadPath(points: newArray)
        path.lineWidth = lineWidth
        color.setStroke()
        path.stroke()

    }

    
}

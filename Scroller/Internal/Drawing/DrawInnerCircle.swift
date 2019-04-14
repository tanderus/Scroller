//
//  DrawInnerCircle.swift
//  Scroller
//
//  Created by Pavel Krasnobrovkin on 13/04/2019.
//

import UIKit

extension Scroller {
    
    public func drawInnerCircle(_ context: CGContext?) {
        
        let circleRect = self.innerCircleRect
        
        context?.saveGState()
        context?.setFillColor(self.circleFill.cgColor)
        context?.fillEllipse(in: circleRect)
        context?.setStrokeColor(self.circleStroke.cgColor)
        context?.setLineWidth(self.circleStrokeWidth)
        context?.strokeEllipse(in: circleRect)
        context?.restoreGState()
    }
    
    public var innerCircleRect: CGRect {
        var rect = self.bounds
        
        let diff = rect.width - rect.height
        let minValue = min(rect.width, rect.height)
        rect.size.width = minValue
        rect.size.height = minValue
        
        if diff < 0 {
            rect.origin.y += -0.5 * diff
        }
        else if 0 < diff {
            rect.origin.x += 0.5 * diff
        }
        
        var inset = self.ringWidth
        inset += self.circleToRingSpacing
        inset += max(0, self.extraTickHeight, self.ballDiameter - self.ringWidth)
        inset += self.valueLabelSize
        return rect.insetBy(dx: inset, dy: inset)
    }
}

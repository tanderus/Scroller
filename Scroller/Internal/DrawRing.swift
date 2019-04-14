//
//  DrawRing.swift
//  Scroller
//
//  Created by Pavel Krasnobrovkin on 13/04/2019.
//

import UIKit

extension Scroller {
    
    public func drawRing(_ context: CGContext?) {
        var rect = self.innerCircleRect
        
        var inset = self.circleToRingSpacing
        inset += 0.5 * self.ringWidth
        rect = rect.insetBy(dx: -inset, dy: -inset)
        
        context?.saveGState()
        context?.setStrokeColor(self.ringColor.cgColor)
        context?.setLineWidth(self.ringWidth)
        context?.strokeEllipse(in: rect)
        context?.restoreGState()
    }
}

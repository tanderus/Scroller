//
//  DrawBall.swift
//  Scroller
//
//  Created by Pavel Krasnobrovkin on 14/04/2019.
//

import UIKit

extension Scroller {
    
    func drawBallIfNeeded(_ context: CGContext?) {
        guard shouldDrawBall else { return }
        
        let innerCircleRect = self.innerCircleRect
        let cX = innerCircleRect.midX
        let cY = innerCircleRect.midY
        
        var scrollerCenterY = innerCircleRect.maxY
        scrollerCenterY += self.circleToRingSpacing
        scrollerCenterY += 0.5 * self.ringWidth
        
        let scrollerRect = CGRect(
            x: cX - 0.5 * self.ballDiameter
            , y: scrollerCenterY - 0.5 * self.ballDiameter
            , width: self.ballDiameter
            , height: self.ballDiameter
        )
        
        let angleRadians = currentAngle * .pi / 180
        
        context?.saveGState()
        context?.translateBy(x: cX, y: cY)
        context?.rotate(by: angleRadians)
        context?.translateBy(x: -cX, y: -cY)
        context?.setFillColor(self.ballFill.cgColor)
        context?.fillEllipse(in: scrollerRect)
        
        context?.setStrokeColor(self.ballStroke.cgColor)
        context?.setLineWidth(self.ballStrokeWidth)
        context?.strokeEllipse(in: scrollerRect)
        context?.restoreGState()
    }
}

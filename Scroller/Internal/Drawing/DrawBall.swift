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
        
        let ballRect = self.ballRectNotRotated
        let angleRadians = currentAngle * .pi / 180
        
        context?.saveGState()
        context?.translateBy(x: cX, y: cY)
        context?.rotate(by: angleRadians)
        context?.translateBy(x: -cX, y: -cY)
        context?.setFillColor(self.ballFill.cgColor)
        context?.fillEllipse(in: ballRect)
        
        context?.setStrokeColor(self.ballStroke.cgColor)
        context?.setLineWidth(self.ballStrokeWidth)
        context?.strokeEllipse(in: ballRect)
        context?.restoreGState()
    }
    
    var ballRectNotRotated: CGRect {
        let innerCircleRect = self.innerCircleRect
        let cX = innerCircleRect.midX
        
        var ballCenterY = innerCircleRect.maxY
        ballCenterY += self.circleToRingSpacing
        ballCenterY += 0.5 * self.ringWidth
        
        return CGRect(
            x: cX - 0.5 * self.ballDiameter
            , y: ballCenterY - 0.5 * self.ballDiameter
            , width: self.ballDiameter
            , height: self.ballDiameter
        )
    }
}

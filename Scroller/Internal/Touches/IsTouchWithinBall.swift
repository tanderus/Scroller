//
//  IsTouchWithinBall.swift
//  Scroller
//
//  Created by Pavel Krasnobrovkin on 28/03/2019.
//  Copyright © 2019 Pavel Krasnobrovkin. All rights reserved.
//

import UIKit

extension Scroller
{
    internal func isTouchWithinBall(_ touch: UITouch) -> Bool
    {
        guard self.shouldDrawBall else { return false }
        
        guard touch.view == self else { return false }
        
        
        let ballCenter = self.ballCenter
        let touchLocation = touch.location(in: self)
        let distanceToBallCenter = distance(aX: ballCenter.x
            , bX: touchLocation.x
            , aY: ballCenter.y
            , bY: touchLocation.y
        )
        
        return distanceToBallCenter <= 0.5 * self.ballDiameter
    }
    
    internal var ballCenter: CGPoint {
        let innerCircle = self.innerCircleRect
        let ballMidX = innerCircle.midX
        
        var ballMidY = innerCircle.maxY
        ballMidY += self.circleToRingSpacing
        ballMidY += 0.5 * self.ringWidth
        
        let radians = self.currentAngle * .pi / 180
        let rotatedBallCenterX = cos(radians) * (ballMidX - innerCircle.midX) - sin(radians) * (ballMidY - innerCircle.midY) + innerCircle.midX
        let rotatedBallCenterY = sin(radians) * (ballMidX - innerCircle.midX) + cos(radians) * (ballMidY - innerCircle.midY) + innerCircle.midY
        return CGPoint(x: rotatedBallCenterX, y: rotatedBallCenterY)
    }
}

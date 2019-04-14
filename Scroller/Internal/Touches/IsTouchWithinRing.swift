//
//  IsTouchWithinRing.swift
//  Scroller
//
//  Created by Pavel Krasnobrovkin on 28/03/2019.
//  Copyright © 2019 Pavel Krasnobrovkin. All rights reserved.
//

import UIKit

extension Scroller
{
    internal func isTouchWithinRing(_ touch: UITouch) -> Bool
    {
        guard touch.view == self else { return false }
        
        let innerCircle = self.innerCircleRect
        let location = touch.location(in: self)
        let distanceToCircleCenter = distance(
            aX: location.x
            , bX: innerCircle.midX
            , aY: location.y
            , bY: innerCircle.midY
        )
        
        let smallRadius = self.distanceFromCircleCenterToRingInnerBorder
        let bigRadius = self.distanceFromCircleCenterToRingOuterBorder
        return smallRadius <= distanceToCircleCenter && distanceToCircleCenter <= bigRadius
    }
    
    internal var distanceFromCircleCenterToRingInnerBorder: CGFloat {
        let innerCircle = self.innerCircleRect
        return 0.5 * innerCircle.width + self.circleToRingSpacing
    }
    
    internal var distanceFromCircleCenterToRingCenter: CGFloat {
        return self.distanceFromCircleCenterToRingInnerBorder + 0.5 * self.ringWidth
    }
    
    internal var distanceFromCircleCenterToRingOuterBorder: CGFloat {
        return self.distanceFromCircleCenterToRingCenter + 0.5 * self.ringWidth
    }
}

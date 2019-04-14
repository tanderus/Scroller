//
//  IsTouchOutsideRing.swift
//  Scroller
//
//  Created by Pavel Krasnobrovkin on 29/03/2019.
//  Copyright © 2019 Pavel Krasnobrovkin. All rights reserved.
//

import Foundation

extension Scroller
{
    internal func isTouchOutsideRing(_ touch: UITouch) -> Bool
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
        
        let bigRadius = self.distanceFromCircleCenterToRingOuterBorder
        return bigRadius < distanceToCircleCenter
    }
}

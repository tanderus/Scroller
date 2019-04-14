//
//  RingCenterCoordinates.swift
//  Scroller
//
//  Created by Pavel Krasnobrovkin on 29/03/2019.
//  Copyright © 2019 Pavel Krasnobrovkin. All rights reserved.
//

import UIKit

extension Scroller
{
    func ringCenterCoordinates(for touch: UITouch) -> CGPoint?
    {
        if false == isTouchWithinRing(touch) && false == isTouchOutsideRing(touch)
        {
            return nil
        }
        
        let innerCircle = self.innerCircleRect
        let cX = innerCircle.midX
        let cY = innerCircle.midY
        
        let location = touch.location(in: self)
        let touchX = location.x
        let touchY = location.y
        
        let circleCenterToTouch = distance(aX: cX, bX: touchX, aY: cY, bY: touchY)
        let circleCenterToRingCenter = self.distanceFromCircleCenterToRingCenter

        let k = circleCenterToRingCenter / circleCenterToTouch
        return CGPoint(x: cX + k * (touchX - cX), y: cY + k * (touchY - cY))
    }
}

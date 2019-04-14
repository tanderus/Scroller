//
//  Distance.swift
//  Scroller
//
//  Created by Pavel Krasnobrovkin on 29/03/2019.
//  Copyright © 2019 Pavel Krasnobrovkin. All rights reserved.
//

import Foundation

internal func distance(aX: CGFloat, bX: CGFloat, aY: CGFloat, bY: CGFloat) -> CGFloat
{
    let xDistance = pow(bX - aX, 2)
    let yDistance = pow(bY - aY, 2)
    return sqrt(xDistance + yDistance)
}

//
//  DrawScroller.swift
//  Scroller
//
//  Created by Pavel Krasnobrovkin on 13/04/2019.
//

import UIKit

extension Scroller {
    
    open func drawScroller(_ context: CGContext?) {
        self.drawRing(context)
        self.drawTicksAndValues(context)
        self.drawInnerCircle(context)
    }
}

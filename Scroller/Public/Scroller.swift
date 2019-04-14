//
//  Scroller.swift
//  Scroller
//
//  Created by Pavel Krasnobrovkin on 13/04/2019.
//

import UIKit

@IBDesignable
open class Scroller: UIControl {
    
    // MARK: -
    // MARK: Inner circle properties
    @IBInspectable var circleFill: UIColor = UIColor.white {
        didSet {
            guard circleFill != oldValue else { return }
            
            self.setNeedsDisplay()
        }
    }
    
    @IBInspectable var circleStroke: UIColor = UIColor.white {
        didSet {
            guard circleStroke != oldValue else { return }
            
            self.setNeedsDisplay()
        }
    }
    
    @IBInspectable var circleStrokeWidth: CGFloat = 0 {
        didSet {
            let newVal = max(0, circleStrokeWidth)
            guard newVal != oldValue else { return }
            
            self.circleStrokeWidth = newVal
            self.setNeedsDisplay()
        }
    }
    
    // MARK: -
    // MARK: Minimum value properties
    @IBInspectable var minimumValue: CGFloat = 0 {
        didSet {
            let newVal = min(minimumValue, maximumValue)
            if newVal != oldValue {
                self.minimumValue = newVal
                self.setNeedsDisplay()
            }
        }
    }
    @IBInspectable var minimumAngle: CGFloat = 15 {
        didSet {
            var newVal = min(359, max(0, minimumAngle))
            newVal = min(minimumAngle, maximumAngle)
            if oldValue != newVal {
                self.maximumAngle = newVal
                self.setNeedsDisplay()
            }
        }
    }
    
    // MARK: -
    // MARK: Maximum value properties
    @IBInspectable var maximumValue: CGFloat = 100 {
        didSet {
            let newVal = max(minimumValue, maximumValue)
            if newVal != oldValue {
                self.maximumValue = newVal
                self.setNeedsDisplay()
            }
        }
    }
    @IBInspectable var maximumAngle: CGFloat = 345 {
        didSet {
            var newVal = min(359, max(0, maximumAngle))
            newVal = max(minimumAngle, maximumAngle)
            if oldValue != newVal {
                self.maximumAngle = newVal
                self.setNeedsDisplay()
            }
        }
    }
    
    // MARK: -
    // MARK: Ring properties
    @IBInspectable var circleToRingSpacing: CGFloat = 2 {
        didSet {
            let newVal = max(0, circleToRingSpacing)
            if oldValue != newVal {
                self.circleToRingSpacing = newVal
                self.setNeedsDisplay()
            }
        }
    }
    
    @IBInspectable var ringColor: UIColor = UIColor(red: 122 / 255.0, green: 196 / 255.0, blue: 178 / 255.0, alpha: 0.2) {
        didSet {
            guard ringColor != oldValue else { return }
            
            self.setNeedsDisplay()
        }
    }
    
    @IBInspectable var ringWidth: CGFloat = 10 {
        didSet {
            let newVal = max(1, ringWidth)
            if oldValue != newVal {
                self.ringWidth = newVal
                self.setNeedsDisplay()
            }
        }
    }
    
    // MARK: -
    public override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        self.drawScroller(context)
    }
}

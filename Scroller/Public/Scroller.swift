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
    @IBInspectable var minimumAngle: CGFloat = 45 {
        didSet {
            var newVal = min(359, max(0, minimumAngle))
            newVal = min(minimumAngle, maximumAngle)
            if oldValue != newVal {
                self.maximumAngle = newVal
                self.setNeedsDisplay()
            }
        }
    }
    
    @IBInspectable var minimumTickColor: UIColor = UIColor.white {
        didSet {
            guard minimumTickColor != oldValue else { return }
            
            self.setNeedsDisplay()
        }
    }
    
    @IBInspectable var minimumTickWidth: CGFloat = 2 {
        didSet {
            guard minimumTickWidth != oldValue else { return }
            
            self.minimumTickWidth = max(1, minimumTickWidth)
            self.setNeedsDisplay()
        }
    }
    
    @IBInspectable var minimumTextColor: UIColor = UIColor.white {
        didSet {
            guard minimumTextColor != oldValue else { return }
            
            self.setNeedsDisplay()
        }
    }
    
    @IBInspectable var minimumFont: UIFont = UIFont.systemFont(ofSize: 14) {
        didSet {
            guard minimumFont != oldValue else { return }
            
            self.setNeedsDisplay()
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
    @IBInspectable var maximumAngle: CGFloat = 315 {
        didSet {
            var newVal = min(359, max(0, maximumAngle))
            newVal = max(minimumAngle, maximumAngle)
            if oldValue != newVal {
                self.maximumAngle = newVal
                self.setNeedsDisplay()
            }
        }
    }
    
    @IBInspectable var maximumTickColor: UIColor = UIColor.white {
        didSet {
            guard maximumTickColor != oldValue else { return }
            
            self.setNeedsDisplay()
        }
    }
    
    @IBInspectable var maximumTickWidth: CGFloat = 2 {
        didSet {
            guard maximumTickWidth != oldValue else { return }
            
            self.maximumTickWidth = max(1, maximumTickWidth)
            self.setNeedsDisplay()
        }
    }
    
    @IBInspectable var maximumTextColor: UIColor = UIColor.white {
        didSet {
            guard maximumTextColor != oldValue else { return }
            
            self.setNeedsDisplay()
        }
    }
    
    @IBInspectable var maximumFont: UIFont = UIFont.systemFont(ofSize: 14) {
        didSet {
            guard maximumFont != oldValue else { return }
            
            self.setNeedsDisplay()
        }
    }
    
    // MARK: -
    // MARK: Current value properties
    @IBInspectable var currentValue: CGFloat = 50 {
        didSet {
            guard currentValue != oldValue else { return }
            
            if currentValue < minimumValue {
                currentValue = minimumValue
            }
            else if maximumValue < currentValue {
                currentValue = maximumValue
            }
            
            self.setNeedsDisplay()
        }
    }
    
    public var currentAngle: CGFloat {
        var part = self.currentValue - self.minimumValue
        part = part / (self.maximumValue - self.minimumValue)
        return self.minimumAngle + part * (self.maximumAngle - self.minimumAngle)
    }
    
    @IBInspectable var currentTickColor: UIColor = UIColor(red: 0, green: 168 / 255.0, blue: 228 / 255.0, alpha: 1) {
        didSet {
            guard currentTickColor != oldValue else { return }
            
            self.setNeedsDisplay()
        }
    }
    
    @IBInspectable var currentTickWidth: CGFloat = 5 {
        didSet {
            guard currentTickWidth != oldValue else { return }
            
            self.currentTickWidth = max(1, currentTickWidth)
            self.setNeedsDisplay()
        }
    }
    
    @IBInspectable var currentTextColor: UIColor = UIColor(red: 0, green: 168 / 255.0, blue: 228 / 255.0, alpha: 1) {
        didSet {
            guard currentTextColor != oldValue else { return }
            
            self.setNeedsDisplay()
        }
    }
    
    @IBInspectable var currentFont: UIFont = UIFont.systemFont(ofSize: 14) {
        didSet {
            guard currentFont != oldValue else { return }
            
            self.setNeedsDisplay()
        }
    }
    
    // MARK: -
    // MARK: Ball properties
    @IBInspectable var shouldDrawBall: Bool = true {
        didSet {
            guard shouldDrawBall != oldValue else { return }
            
            self.setNeedsDisplay()
        }
    }
    
    @IBInspectable var ballDiameter: CGFloat = 30 {
        didSet {
            guard ballDiameter != oldValue else { return }
            
            ballDiameter = max(1, min(ballDiameter, ringWidth + 10))
            
            self.setNeedsDisplay()
        }
    }
    
    @IBInspectable var ballFill: UIColor = UIColor(red: 0, green: 168 / 255.0, blue: 228 / 255.0, alpha: 1) {
        didSet {
            guard ballFill != oldValue else { return }
            
            self.setNeedsDisplay()
        }
    }
    
    @IBInspectable var ballStroke: UIColor = UIColor.black {
        didSet {
            guard ballStroke != oldValue else { return }
            
            self.setNeedsDisplay()
        }
    }
    
    @IBInspectable var ballStrokeWidth: CGFloat = 2 {
        didSet {
            guard ballStrokeWidth != oldValue else { return }
            
            self.setNeedsDisplay()
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
    
    @IBInspectable var ringWidth: CGFloat = 20 {
        didSet {
            let newVal = max(1, ringWidth)
            if oldValue != newVal {
                self.ringWidth = newVal
                self.ballDiameter = (ballDiameter > newVal + 10) ? newVal + 10 : ballDiameter
                self.setNeedsDisplay()
            }
        }
    }
    
    // MARK: -
    open override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        self.drawScroller(context)
    }
}

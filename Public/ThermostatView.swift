//
//  Scroller.swift
//  Scroller
//
//  Created by Pavel Krasnobrovkin on 22/03/2019.
//  Copyright © 2019 Pavel Krasnobrovkin. All rights reserved.
//

import UIKit

@IBDesignable
public class Scroller: UIControl
{
    init()
    {
        super.init(frame: .zero)
        self.initialSetup()
    }
    
    public override init(frame: CGRect)
    {
        super.init(frame: frame)
        self.initialSetup()
    }
    
    public required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        self.initialSetup()
    }
    
    internal func initialSetup()
    {
        self.isMultipleTouchEnabled = false
    }
    
    @IBInspectable public var showScroller: Bool = false {
        didSet {
            if oldValue == showScroller { return }
            self.setNeedsDisplay()
        }
    }
    
    let scrollerDiameter: CGFloat = 30
    let scrollerFillColor: UIColor = UIColor.white
    let scrollerStrokeColor: UIColor = UIColor.blue
    let scrollerStrokeWidth: CGFloat = 5
    
    // MARK: -
    // MARK: Current Actual Value properties
    @IBInspectable public var currentActualValue: CGFloat = 21 {
        didSet {
            if oldValue == currentActualValue { return }
            
            if self.currentActualValue < self.minimumValue
            {
                self.currentActualValue = self.minimumValue
            }
            else if self.maximumValue < self.currentActualValue
            {
                self.currentActualValue = self.maximumValue
            }
            self.setNeedsDisplay()
        }
    }
    
    var currentActualValueAngleDegrees: CGFloat {
        var part = self.currentActualValue - self.minimumValue
        part = part / (self.maximumValue - self.minimumValue)
        return self.minimumValueAngleDegrees + part * (self.maximumValueAngleDegrees - self.minimumValueAngleDegrees)
    }
    
    let currentActualValueTickColor: UIColor = UIColor.blue
    let currentActualValueTextColor: UIColor = UIColor.blue
    
    // MARK: -
    // MARK: Minimum Value properties
    @IBInspectable public var minimumValue: CGFloat = 0 {
        didSet {
            if oldValue == minimumValue { return }
            self.setNeedsDisplay()
        }
    }

    @IBInspectable var minimumValueAngleDegrees: CGFloat = 20 {
        didSet {
            if oldValue == minimumValueAngleDegrees { return }
            self.setNeedsDisplay()
        }
    }
    
    let minimumValueTickColor: UIColor = ColorPalette.white
    let minimumValueTextColor: UIColor = ColorPalette.white
    
    // MARK: -
    // MARK: Maximum Value properties
    @IBInspectable public var maximumValue: CGFloat = 50 {
        didSet {
            if oldValue == maximumValue { return }
            self.setNeedsDisplay()
        }
    }
    
    @IBInspectable var maximumValueAngleDegrees: CGFloat = 340 {
        didSet {
            if oldValue == maximumValueAngleDegrees { return }
            
            self.setNeedsDisplay()
        }
    }
    
    let maximumValueTickColor: UIColor = ColorPalette.white
    let maximumValueTextColor: UIColor = ColorPalette.white
    
    // MARK: -
    // MARK: Circle and ring properties
    @IBInspectable var innerCircleColor: UIColor = ColorPalette.white {
        didSet {
            if oldValue == innerCircleColor { return }
            self.setNeedsDisplay()
        }
    }
    
    @IBInspectable var circleToRingSpacing: CGFloat = 3 {
        didSet {
            if oldValue == circleToRingSpacing { return }
            self.setNeedsDisplay()
        }
    }
    
    let ringRadius: CGFloat = 22
    let ringColor: UIColor = UIColor(red: 122 / 255.0, green: 196 / 255.0, blue: 178 / 255.0, alpha: 0.2)
    
    // MARK: -
    // MARK: Ticks
    let ticksFont: UIFont = UIFont(name: "OpenSans-Italic", size: 13)!
    let ticksWidth: CGFloat = 5
    
    let minimumValueTickExtraSize: CGFloat = 0
    let maximumValueTickExtraSize: CGFloat = 0
    let currentSetValueTickExtraSize: CGFloat = 6
    let currentActualValueTickExtraSize: CGFloat = 6
    
    ///
    /// Maximum of width and height required
    ///
    @IBInspectable var valueLabelsMaxSize: CGFloat = 20 {
        didSet {
            if oldValue == valueLabelsMaxSize { return }
            self.setNeedsDisplay()
        }
    }
    
    // MARK: -
    // MARK: Drawing
    public override func draw(_ rect: CGRect)
    {
        super.draw(rect)
        
        let context = UIGraphicsGetCurrentContext()
        self.drawThermostat(in: context)
    }
    
    // MARK: -
    // MARK: Touches Processing
    private var isDraggingScroller = false
    private var latestRingCenter = CGPoint.zero
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        guard showScroller else { return }
        
        guard let touch = touches.first else { return }
        
        guard touch.view == self else { return }
        
        if self.isTouchWithinScroller(touch)
        {
            self.isDraggingScroller = true
            self.latestRingCenter = self.scrollerCenter
        }
    }
    
    public override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        guard let touch = touches.first else { return }
        
        guard touch.view == self else { return }
        
        guard isDraggingScroller else { return }
        
        guard let ringCenter = self.ringCenterCoordinates(for: touch) else { return }
        
        let scrollerCenter = self.scrollerCenter
        if self.minimumValue == self.currentSetValue
        {
            // Trying to scroll right from the minimum value tick
            if scrollerCenter.x < ringCenter.x { return }
        }
        else if self.maximumValue == self.currentSetValue
        {
            // Trying to scroll left from the maximum value tick
            if ringCenter.x < scrollerCenter.x { return }
        }
        
        let innerCircle = self.innerCircleBounds
        let chorde = distance(
            aX: ringCenter.x
            , bX: innerCircle.midX
            , aY: ringCenter.y
            , bY: innerCircle.maxY + self.circleToRingSpacing + 0.5 * self.ringRadius
        )
        
        var resultAngleDegrees: CGFloat = 2 * asin( chorde / (2 * distanceFromCircleCenterToRingCenter) )
        resultAngleDegrees = resultAngleDegrees * 180 / .pi
        if innerCircle.midX < ringCenter.x
        {
            resultAngleDegrees = 360 - resultAngleDegrees
        }
        
        resultAngleDegrees = max(self.minimumValueAngleDegrees, min(resultAngleDegrees, self.maximumValueAngleDegrees))
        
        var part = resultAngleDegrees - self.minimumValueAngleDegrees
        part = part / (self.maximumValueAngleDegrees - self.minimumValueAngleDegrees)
        let resultValue = self.minimumValue + part * (self.maximumValue - self.minimumValue)
        if resultValue != self.currentSetValue
        {
            self.currentSetValue = resultValue
            latestRingCenter = self.scrollerCenter
            self.sendActions(for: .valueChanged)
        }
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        self.isDraggingScroller = false
    }
    
    public override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        self.isDraggingScroller = false
    }
}

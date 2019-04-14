//
//  DrawTicksAndValues.swift
//  Scroller
//
//  Created by Pavel Krasnobrovkin on 13/04/2019.
//

import UIKit

extension Scroller {
    
    internal var extraTickHeight: CGFloat {
        return 5
    }
    
    internal var valueLabelSize: CGFloat {
        return 30
    }
    
    public func drawTicksAndValues(_ context: CGContext?) {
        if currentValue != minimumValue || shouldDrawBall {
            drawMinimumValueTick(context)
        }
        if currentValue != maximumValue || shouldDrawBall {
            drawMaximumValueTick(context)
        }
        
        if !shouldDrawBall {
            drawCurrentValueTick(context)
        }
    }
    
    private func drawMinimumValueTick(_ context: CGContext?) {
        self.drawValueTick(context
            , angleDegrees: self.minimumAngle
            , tickValue: self.minimumValue
            , extraHeight: extraTickHeight
            , tickWidth: self.minimumTickWidth
            , tickColor: self.minimumTickColor
            , textColor: self.minimumTextColor
            , textFont: self.minimumFont
            , valueLabelSize: self.valueLabelSize
        )
    }
    
    private func drawMaximumValueTick(_ context: CGContext?) {
        self.drawValueTick(context
            , angleDegrees: self.maximumAngle
            , tickValue: self.maximumValue
            , extraHeight: extraTickHeight
            , tickWidth: self.maximumTickWidth
            , tickColor: self.maximumTickColor
            , textColor: self.maximumTextColor
            , textFont: self.maximumFont
            , valueLabelSize: self.valueLabelSize
        )
    }
    
    private func drawCurrentValueTick(_ context: CGContext?) {
        self.drawValueTick(context
            , angleDegrees: self.currentAngle
            , tickValue: self.currentValue
            , extraHeight: extraTickHeight
            , tickWidth: self.currentTickWidth
            , tickColor: self.currentTickColor
            , textColor: self.currentTextColor
            , textFont: self.currentFont
            , valueLabelSize: self.valueLabelSize
        )
    }
    
    private func drawValueTick(_ context: CGContext?
        , angleDegrees: CGFloat
        , tickValue: CGFloat
        , extraHeight: CGFloat
        , tickWidth: CGFloat
        , tickColor: UIColor
        , textColor: UIColor
        , textFont: UIFont
        , valueLabelSize: CGFloat)
    {
        let innerCircleRect = self.innerCircleRect
        let cX = innerCircleRect.midX
        let cY = innerCircleRect.midY
        
        var tickHeight = self.circleToRingSpacing
        tickHeight += self.ringWidth
        tickHeight += extraHeight
        
        let tickRect = CGRect(x: cX - 0.5 * tickWidth
            , y: innerCircleRect.maxY
            , width: tickWidth
            , height: tickHeight
        )
        
        let angleRadians = angleDegrees * .pi / 180
        
        context?.saveGState()
        context?.translateBy(x: cX, y: cY)
        context?.rotate(by: angleRadians)
        context?.translateBy(x: -cX, y: -cY)
        context?.setFillColor(tickColor.cgColor)
        context?.fill(tickRect)
        
        // Render value text
        let deltaX = tickRect.midX
        let deltaY = tickRect.maxY + 0.5 * valueLabelSize
        context?.translateBy(x: deltaX, y: deltaY)
        context?.rotate(by: -angleRadians)
        
        let label = UILabel()
        label.text = "\(Int(tickValue))"
        label.font = textFont
        label.textAlignment = .center
        label.textColor = textColor
        
        let textWidth = valueLabelSize
        label.drawText(in: CGRect(x: -0.5 * textWidth, y: -0.5 * textWidth, width: textWidth, height: textWidth) )
        context?.restoreGState()
    }
}

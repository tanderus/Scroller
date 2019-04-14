//
//  ViewController.swift
//  Scroller
//
//  Created by 6lackk@gmail.com on 04/13/2019.
//  Copyright (c) 2019 6lackk@gmail.com. All rights reserved.
//

import UIKit
import Scroller

class ViewController: UIViewController {
    
    @IBOutlet private weak var scroller: Scroller!
    @IBOutlet private weak var valueLabel: UILabel!
    
    @IBAction private func scrollerValueChanged() {
        let value = scroller.currentValue
        self.valueLabel.text = "Value: \(Int(value))"
    }
}


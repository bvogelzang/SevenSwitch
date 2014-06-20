//
//  SevenSwitch.swift
//
//  Created by Benjamin Vogelzang on 6/20/14.
//  Copyright (c) 2014 Ben Vogelzang. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import UIKit
import QuartzCore

class SevenSwitch: UIControl {
    
    // public
    var on: Bool
    var activeColor: UIColor
    var inactiveColor: UIColor
    var onTintColor: UIColor
    var offTintColor: UIColor
    var borderColor: UIColor
    var thumbTintColor: UIColor
    var onThumbTintColor: UIColor
    var shadowColor: UIColor
    var isRounded: Bool
    var thumbImage: UIImage
    var onImage: UIImage
    var offImage: UIImage
    var onLabel: UILabel
    var offLabel: UILabel
    
    // private
    var backgroundView: UIView
    var thumbView: UIView
    var onImageView: UIImageView
    var offImageView: UIImageView
    var thumbImageView: UIImageView
    var currentVisualValue: Bool
    var startTrackingValue: Bool
    var didChangeWhileTracking: Bool
    var isAnimating: Bool
    var userDidSpecifyOnThumbTintColor: Bool
    
    init() {
        super.initWithFrame(CGRectMake(0, 0, 50, 30))
        setup()
    }
    
    init(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
        setup()
    }
    
    init(frame: CGRect) {
        let initialFrame = CGRectIsEmpty(frame) ? CGRectMake(0, 0, 50, 30) : frame;
        super.initWithFrame(initialFrame)
        setup()
    }
    
    func setup() {
        
        self.on = false
        self.isRounded = true
        self.currentVisualValue = false
        self.userDidSpecifyOnThumbTintColor = false
        self.isAnimating = false
        
        // default colors
        self.inactiveColor = UIColor.clearColor()
        self.activeColor = UIColor(0.89, 0.89, 0.89, 1)
        self.onTintColor = UIColor(0.3, 0.85, 0.39, 1)
        self.borderColor = UIColor(0.78, 0.78, 0.8, 1)
        self.thumbTintColor = UIColor.whiteColor()
        self.onThumbTintColor = UIColor.whiteColor()
        self.shadowColor = UIColor.grayColor()
        
        // background
        self.backgroundView = UIView(frame: CGRectMake(0, 0, self.frame.size.width, self.frame.size.height))
        backgroundView.backgroundColor = UIColor.clearColor()
        backgroundView.layer.cornerRadius = self.frame.size.height * 0.5
        backgroundView.layer.borderColor = self.borderColor.CGColor
        backgroundView.layer.borderWidth = 1.0
        backgroundView.userInteractionEnabled = false
        backgroundView.clipsToBounds = true
        self.addSubview(backgroundView)
        
        // on/off images
        self.onImageView = UIImageView(frame: CGRectMake(0, 0, self.frame.size.width - self.frame.size.height, self.frame.size.height))
        onImageView.alpha = 1.0
        onImageView.contentMode = UIViewContentMode.Center
        backgroundView.addSubview(onImageView)
        
        self.offImageView = UIImageView(frame: CGRectMake(self.frame.size.height, 0, self.frame.size.width - self.frame.size.height, self.frame.size.height))
        offImageView.alpha = 1.0
        offImageView.contentMode = UIViewContentMode.Center
        backgroundView.addSubview(offImageView)
        
        // labels
        self.onLabel = UILabel(frame: CGRectMake(0, 0, self.frame.size.width - self.frame.size.height, self.frame.size.height))
        onLabel.textAlignment = NSTextAlignment.Center
        onLabel.textColor = UIColor.lightGrayColor()
        onLabel.font = UIFont.systemFontOfSize(12)
        backgroundView.addSubview(onLabel)
        
        self.offLabel = UILabel(frame: CGRectMake(self.frame.size.height, 0, self.frame.size.width - self.frame.size.height, self.frame.size.height))
        offLabel.textAlignment = NSTextAlignment.Center
        offLabel.textColor = UIColor.lightGrayColor()
        offLabel.font = UIFont.systemFontOfSize(12)
        backgroundView.addSubview(offLabel)
        
        // thumb
        self.thumb = UIView(frame: CGRectMake(1, 1, self.frame.size.height - 2, self.frame.size.height - 2))
        thumb.backgroundColor = self.thumbTintColor
        thumb.layer.cornerRadius = (self.frame.size.height * 0.5) - 1
        thumb.layer.shadowColor = self.shadowColor.CGColor
        thumb.layer.shadowRadius = 2.0
        thumb.layer.shadowOpacity = 0.5
        thumb.layer.shadowOffset = CGSizeMake(0, 3)
        thumb.layer.shadowPath = UIBezierPath(roundedRect: knob.bounds, cornerRadius: knob.layer.cornerRadius).CGPath;
        thumb.layer.masksToBounds = false
        thumb.userInteractionEnabled = false
        self.addSubview(thumb)
        
        // thumb image
        self.thumbImageView = UIImageView(frame: CGRectMake(0, 0, knob.frame.size.width, knob.frame.size.height))
        thumbImageView.contentMode = UIViewContentMode.Center
        thumbImageView.autoresizingMask = UIViewAutoresizing.FlexibleWidth
        thumb.addSubview(thumbImageView)
    }
    
    func showOn(animated: Bool) {
        
    }
    
    func showOff(animated: Bool) {
        
    }
    
    func setOn(on: Bool, animated: Bool) {
        
    }
    
    func isOn() -> Bool {
        
    }
}

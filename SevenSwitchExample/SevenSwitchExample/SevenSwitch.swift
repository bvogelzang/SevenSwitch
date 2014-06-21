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

@objc class SevenSwitch: UIControl {
    
    // public
    
    /*
    *   Set (without animation) whether the switch is on or off
    */
    var on: Bool {
    get { return on }
    set {
        self.setOn(newValue, animated: false)
    }
    }
    
    /*
    *	Sets the background color that shows when the switch off and actively being touched.
    *   Defaults to light gray.
    */
    var activeColor: UIColor {
    willSet {
        if self.on && !self.isTracking {
            backgroundView.backgroundColor = newValue
        }
    }
    }
    
    /*
    *	Sets the background color when the switch is off.
    *   Defaults to clear color.
    */
    var inactiveColor: UIColor {
    willSet {
        if !self.on && !self.isTracking {
            backgroundView.backgroundColor = newValue
        }
    }
    }
    
    /*
    *   Sets the background color that shows when the switch is on.
    *   Defaults to green.
    */
    var onTintColor: UIColor {
    willSet {
        if self.on && !self.isTracking {
            backgroundView.backgroundColor = newValue
            backgroundView.layer.borderColor = newValue.CGColor
        }
    }
    }
    
    //var offTintColor: UIColor
    
    /*
    *   Sets the border color that shows when the switch is off. Defaults to light gray.
    */
    var borderColor: UIColor {
    willSet {
        if !self.on {
            backgroundView.layer.borderColor = newValue.CGColor
        }
    }
    }
    
    /*
    *	Sets the knob color. Defaults to white.
    */
    var thumbTintColor: UIColor {
    willSet {
        if !userDidSpecifyOnThumbTintColor {
            onThumbTintColor = newValue
        }
        if (!userDidSpecifyOnThumbTintColor || !self.on) && !self.isTracking {
            thumb.backgroundColor = newValue
        }
    }
    }
    
    /*
    *	Sets the knob color that shows when the switch is on. Defaults to white.
    */
    var onThumbTintColor: UIColor {
    willSet {
        userDidSpecifyOnThumbTintColor = YES
        if self.on && !self.isTracking {
            thumb.backgroundColor = newValue
        }
    }
    }
    
    /*
    *	Sets the shadow color of the knob. Defaults to gray.
    */
    var shadowColor: UIColor {
    willSet {
        thumb.layer.shadowColor = newValue.CGColor
    }
    }
    
    /*
    *	Sets whether or not the switch edges are rounded.
    *   Set to NO to get a stylish square switch.
    *   Defaults to YES.
    */
    var isRounded: Bool {
    willSet {
        if newValue {
            backgroundView.layer.cornerRadius = self.frame.size.height * 0.5
            thumb.layer.cornerRadius = (self.frame.size.height * 0.5) - 1
        }
        else {
            backgroundView.layer.cornerRadius = 2
            thumb.layer.cornerRadius = 2
        }
        
        thumb.layer.shadowPath = UIBezierPath(roundedRect: thumb.bounds, cornerRadius: thumb.layer.cornerRadius).CGPath
    }
    }
    
    /*
    *   Sets the image that shows on the switch thumb.
    */
    var thumbImage: UIImage {
    willSet {
        thumbImageView.image = newValue
    }
    }
    
    /*
    *   Sets the image that shows when the switch is on.
    *   The image is centered in the area not covered by the knob.
    *   Make sure to size your images appropriately.
    */
    var onImage: UIImage {
    willSet {
        onImageView.image = newValue
    }
    }
    
    /*
    *	Sets the image that shows when the switch is off.
    *   The image is centered in the area not covered by the knob.
    *   Make sure to size your images appropriately.
    */
    var offImage: UIImage {
    willSet {
        offImageView.image = newValue
    }
    }
    
    /*
    *	Sets the text that shows when the switch is on.
    *   The text is centered in the area not covered by the knob.
    */
    var onLabel: UILabel
    
    /*
    *	Sets the text that shows when the switch is off.
    *   The text is centered in the area not covered by the knob.
    */
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
    
    /*
    *   Initialization
    */
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
    
    
    /*
    *   Setup the individual elements of the switch and set default values
    */
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
        thumb.layer.shadowPath = UIBezierPath(roundedRect: thumb.bounds, cornerRadius: thumb.layer.cornerRadius).CGPath;
        thumb.layer.masksToBounds = false
        thumb.userInteractionEnabled = false
        self.addSubview(thumb)
        
        // thumb image
        self.thumbImageView = UIImageView(frame: CGRectMake(0, 0, thumb.frame.size.width, thumb.frame.size.height))
        thumbImageView.contentMode = UIViewContentMode.Center
        thumbImageView.autoresizingMask = UIViewAutoresizing.FlexibleWidth
        thumb.addSubview(thumbImageView)
    }
    
    func beginTrackingWithTouch(touch: UITouch!, withEvent event: UIEvent!) -> Bool {
        super.beginTrackingWithTouch(touch, withEvent: event)
        
        startTrackingValue = self.on
        didChangeWhileTracking = false
        
        let activeKnobWidth = self.bounds.size.height - 2 + 5
        isAnimating = true
        
        UIView.animateWithDuration(0.3, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut | UIViewAnimationOptions.BeginFromCurrentState, animations: {
                if self.on {
                    thumb.frame = CGRectMake(self.bounds.size.width - (activeKnobWidth + 1), thumb.frame.origin.y, activeKnobWidth, thumb.frame.size.height)
                    backgroundView.backgroundColor = self.onTintColor
                    thumb.backgroundColor = self.onThumbTintColor
                }
                else {
                    thumb.frame = CGRectMake(thumb.frame.origin.x, thumb.frame.origin.y, activeKnobWidth, thumb.frame.size.height)
                    backgroundView.backgroundColor = self.activeColor
                    thumb.backgroundColor = self.thumbTintColor
                }
            }, completion: {
                isAnimating = false
        })
        
        return true
    }
    
    func continueTrackingWithTouch(touch: UITouch!, withEvent event: UIEvent!) -> Bool {
        super.continueTrackingWithTouch(touch, withEvent: event)
        
        // Get touch location
        let lastPoint = touch.locationInView(self)
        
        // update the switch to the correct visuals depending on if
        // they moved their touch to the right or left side of the switch
        if lastPoint.x > self.bounds.size.width * 0.5 {
            self.showOn(true)
            if !startTrackingValue {
                didChangeWhileTracking = true
            }
        }
        else {
            self.showOff(true)
            if startTrackingValue {
                didChangeWhileTracking = true
            }
        }

        return true
    }
    
    func endTrackingWithTouch(touch: UITouch!, withEvent event: UIEvent!) {
        super.endTrackingWithTouch(touch, withEvent: event)
        
        previousValue = self.on
        
        if didChangeWhileTracking {
            self.setOn(currentVisualValue, animated: true)
        }
        else {
            self.setOn(!self.on, animated: true)
        }
        
        if previousValue != self.on {
            self.sendActionsForControlEvents(UIControlEvent.ValueChanged)
        }
    }
    
    func cancelTrackingWithEvent(event: UIEvent) {
        super.cancelTrackingWithEvent(event)
        
        // just animate back to the original value
        if self.on {
            self.showOn(true)
        }
        else {
            self.showOff(true)
        }
    }
    
    func layoutSubviews() {
        super.layoutSubviews()
        
        if !isAnimating {
            let frame = self.frame
            
            // background
            backgroundView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height)
            backgroundView.layer.cornerRadius = self.isRounded ? frame.size.height * 0.5 : 2
            
            // images
            onImageView.frame = CGRectMake(0, 0, frame.size.width - frame.size.height, frame.size.height)
            offImageView.frame = CGRectMake(frame.size.height, 0, frame.size.width - frame.size.height, frame.size.height)
            self.onLabel.frame = CGRectMake(0, 0, frame.size.width - frame.size.height, frame.size.height)
            self.offLabel.frame = CGRectMake(frame.size.height, 0, frame.size.width - frame.size.height, frame.size.height)
            
            // thumb
            let normalKnobWidth = frame.size.height - 2
            if self.on {
                thumb.frame = CGRectMake(frame.size.width - (normalKnobWidth + 1), 1, frame.size.height - 2, normalKnobWidth)
            }
            else {
                thumb.frame = CGRectMake(1, 1, normalKnobWidth, normalKnobWidth)
            }
            
            thumb.layer.cornerRadius = self.isRounded ? (frame.size.height * 0.5) - 1 : 2
        }
    }
    
    /*
    *   Set the state of the switch to on or off, optionally animating the transition.
    */
    func setOn(on: Bool, animated: Bool) {
        if on {
            self.showOn(animated)
        }
        else {
            self.showOff(animated)
        }
    }
    
    /*
    *   Detects whether the switch is on or off
    *
    *	@return	BOOL YES if switch is on. NO if switch is off
    */
    func isOn() -> Bool {
        return self.on
    }
    
    /*
    *   update the looks of the switch to be in the on position
    *   optionally make it animated
    */
    func showOn(animated: Bool) {
        let normalKnobWidth = self.bounds.size.height - 2
        let activeKnobWidth = normalKnobWidth + 5
        if animated {
            isAnimating = true
            UIView.animateWithDuration(0.3, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut | UIViewAnimationOptions.BeginFromCurrentState, animations: {
                if self.tracking {
                    thumb.frame = CGRectMake(self.bounds.size.width - (activeKnobWidth + 1), thumb.frame.origin.y, activeKnobWidth, thumb.frame.size.height)
                }
                else {
                    thumb.frame = CGRectMake(self.bounds.size.width - (normalKnobWidth + 1), thumb.frame.origin.y, normalKnobWidth, thumb.frame.size.height)
                }
                
                backgroundView.backgroundColor = self.onTintColor
                backgroundView.layer.borderColor = self.onTintColor.CGColor
                thumb.backgroundColor = self.onThumbTintColor
                onImageView.alpha = 1.0
                offImageView.alpha = 0
                onLabel.alpha = 1.0
                offLabel.alpha = 0
            }, completion: {
                isAnimating = false
            })
        }
        else {
            if self.tracking {
                thumb.frame = CGRectMake(self.bounds.size.width - (activeKnobWidth + 1), thumb.frame.origin.y, activeKnobWidth, thumb.frame.size.height)
            }
            else {
                thumb.frame = CGRectMake(self.bounds.size.width - (normalKnobWidth + 1), thumb.frame.origin.y, normalKnobWidth, thumb.frame.size.height)
            }
            
            backgroundView.backgroundColor = self.onTintColor
            backgroundView.layer.borderColor = self.onTintColor.CGColor
            thumb.backgroundColor = self.onThumbTintColor
            onImageView.alpha = 1.0
            offImageView.alpha = 0
            onLabel.alpha = 1.0
            offLabel.alpha = 0
        }
        
        currentVisualValue = true
    }
    
    /*
    *   update the looks of the switch to be in the off position
    *   optionally make it animated
    */
    func showOff(animated: Bool) {
        let normalKnobWidth = self.bounds.size.height - 2
        let activeKnobWidth = normalKnobWidth + 5
        
        if animated {
            isAnimating = true
            UIView.animateWithDuration(0.3, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut | UIViewAnimationOptions.BeginFromCurrentState, animations: {
                if self.tracking {
                    thumb.frame = CGRectMake(1, thumb.frame.origin.y, activeKnobWidth, thumb.frame.size.height);
                    backgroundView.backgroundColor = self.activeColor
                }
                else {
                    thumb.frame = CGRectMake(1, thumb.frame.origin.y, normalKnobWidth, thumb.frame.size.height);
                    backgroundView.backgroundColor = self.inactiveColor
                }
                
                backgroundView.layer.borderColor = self.borderColor.CGColor
                thumb.backgroundColor = self.thumbTintColor
                onImageView.alpha = 0
                offImageView.alpha = 1.0
                self.onLabel.alpha = 0
                self.offLabel.alpha = 1.0
                
            }, completion: {
                isAnimating = false
            })
        }
        else {
            if (self.tracking) {
                thumb.frame = CGRectMake(1, thumb.frame.origin.y, activeKnobWidth, thumb.frame.size.height)
                backgroundView.backgroundColor = self.activeColor
            }
            else {
                thumb.frame = CGRectMake(1, thumb.frame.origin.y, normalKnobWidth, thumb.frame.size.height)
                backgroundView.backgroundColor = self.inactiveColor
            }
            backgroundView.layer.borderColor = self.borderColor.CGColor
            thumb.backgroundColor = self.thumbTintColor
            onImageView.alpha = 0
            offImageView.alpha = 1.0
            onLabel.alpha = 0
            offLabel.alpha = 1.0
        }
        
        currentVisualValue = false
    }
    
    
}

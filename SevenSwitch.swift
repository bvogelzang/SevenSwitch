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

@IBDesignable @objc open class SevenSwitch: UIControl {
    
    // public
    
    /*
    *   Set (without animation) whether the switch is on or off
    */
    @IBInspectable open var on: Bool {
        get {
            return switchValue
        }
        set {
            switchValue = newValue
            self.setOn(newValue, animated: false)
        }
    }

    /*
    *	Sets the background color that shows when the switch off and actively being touched.
    *   Defaults to light gray.
    */
    @IBInspectable open var activeColor: UIColor = UIColor(red: 0.89, green: 0.89, blue: 0.89, alpha: 1) {
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
    @IBInspectable open var inactiveColor: UIColor = UIColor.clear {
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
    @IBInspectable open var onTintColor: UIColor = UIColor(red: 0.3, green: 0.85, blue: 0.39, alpha: 1) {
        willSet {
            if self.on && !self.isTracking {
                backgroundView.backgroundColor = newValue
                backgroundView.layer.borderColor = newValue.cgColor
            }
        }
    }
    
    /*
    *   Sets the border color that shows when the switch is off. Defaults to light gray.
    */
    @IBInspectable open var borderColor: UIColor = UIColor(red: 0.78, green: 0.78, blue: 0.8, alpha: 1) {
        willSet {
            if !self.on {
                backgroundView.layer.borderColor = newValue.cgColor
            }
        }
    }
    
    /*
    *	Sets the knob color. Defaults to white.
    */
    @IBInspectable open var thumbTintColor: UIColor = UIColor.white {
        willSet {
            if !userDidSpecifyOnThumbTintColor {
                onThumbTintColor = newValue
            }
            if (!userDidSpecifyOnThumbTintColor || !self.on) && !self.isTracking {
                thumbView.backgroundColor = newValue
            }
        }
    }
    
    /*
    *	Sets the knob color that shows when the switch is on. Defaults to white.
    */
    @IBInspectable open var onThumbTintColor: UIColor = UIColor.white {
        willSet {
            userDidSpecifyOnThumbTintColor = true
            if self.on && !self.isTracking {
                thumbView.backgroundColor = newValue
            }
        }
    }
    
    /*
    *	Sets the shadow color of the knob. Defaults to gray.
    */
    @IBInspectable open var shadowColor: UIColor = UIColor.gray {
        willSet {
            thumbView.layer.shadowColor = newValue.cgColor
        }
    }
    
    /*
    *	Sets whether or not the switch edges are rounded.
    *   Set to NO to get a stylish square switch.
    *   Defaults to YES.
    */
    @IBInspectable open var isRounded: Bool = true {
        willSet {
            if newValue {
                backgroundView.layer.cornerRadius = self.frame.size.height * 0.5
                thumbView.layer.cornerRadius = (self.frame.size.height * 0.5) - 1
            }
            else {
                backgroundView.layer.cornerRadius = 2
                thumbView.layer.cornerRadius = 2
            }
            
            thumbView.layer.shadowPath = UIBezierPath(roundedRect: thumbView.bounds, cornerRadius: thumbView.layer.cornerRadius).cgPath
        }
    }
    
    /*
    *   Sets the image that shows on the switch thumb.
    */
    @IBInspectable open var thumbImage: UIImage! {
        willSet {
            thumbImageView.image = newValue
        }
    }
    
    /*
    *   Sets the image that shows when the switch is on.
    *   The image is centered in the area not covered by the knob.
    *   Make sure to size your images appropriately.
    */
    @IBInspectable open var onImage: UIImage! {
        willSet {
            onImageView.image = newValue
        }
    }
    
    /*
    *	Sets the image that shows when the switch is off.
    *   The image is centered in the area not covered by the knob.
    *   Make sure to size your images appropriately.
    */
    @IBInspectable open var offImage: UIImage! {
        willSet {
            offImageView.image = newValue
        }
    }
    
    /*
    *	Sets the text that shows when the switch is on.
    *   The text is centered in the area not covered by the knob.
    */
    open var onLabel: UILabel!
    
    /*
    *	Sets the text that shows when the switch is off.
    *   The text is centered in the area not covered by the knob.
    */
    open var offLabel: UILabel!
    
    // internal
    internal var backgroundView: UIView!
    internal var thumbView: UIView!
    internal var onImageView: UIImageView!
    internal var offImageView: UIImageView!
    internal var thumbImageView: UIImageView!
    // private
    fileprivate var currentVisualValue: Bool = false
    fileprivate var startTrackingValue: Bool = false
    fileprivate var didChangeWhileTracking: Bool = false
    fileprivate var isAnimating: Bool = false
    fileprivate var userDidSpecifyOnThumbTintColor: Bool = false
    fileprivate var switchValue: Bool = false
    
    /*
    *   Initialization
    */
    public convenience init() {
        self.init(frame: CGRect(x: 0, y: 0, width: 50, height: 30))
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.setup()
    }
    
    override public init(frame: CGRect) {
        let initialFrame = frame.isEmpty ? CGRect(x: 0, y: 0, width: 50, height: 30) : frame
        super.init(frame: initialFrame)
        
        self.setup()
    }
    
    
    /*
    *   Setup the individual elements of the switch and set default values
    */
    fileprivate func setup() {
        
        // background
        self.backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height))
        backgroundView.backgroundColor = UIColor.clear
        backgroundView.layer.cornerRadius = self.frame.size.height * 0.5
        backgroundView.layer.borderColor = self.borderColor.cgColor
        backgroundView.layer.borderWidth = 1.0
        backgroundView.isUserInteractionEnabled = false
        backgroundView.clipsToBounds = true
        self.addSubview(backgroundView)
        
        // on/off images
        self.onImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width - self.frame.size.height, height: self.frame.size.height))
        onImageView.alpha = 1.0
        onImageView.contentMode = UIView.ContentMode.center
        backgroundView.addSubview(onImageView)
        
        self.offImageView = UIImageView(frame: CGRect(x: self.frame.size.height, y: 0, width: self.frame.size.width - self.frame.size.height, height: self.frame.size.height))
        offImageView.alpha = 1.0
        offImageView.contentMode = UIView.ContentMode.center
        backgroundView.addSubview(offImageView)
        
        // labels
        self.onLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.size.width - self.frame.size.height, height: self.frame.size.height))
        onLabel.textAlignment = NSTextAlignment.center
        onLabel.textColor = UIColor.lightGray
        onLabel.font = UIFont.systemFont(ofSize: 12)
        backgroundView.addSubview(onLabel)
        
        self.offLabel = UILabel(frame: CGRect(x: self.frame.size.height, y: 0, width: self.frame.size.width - self.frame.size.height, height: self.frame.size.height))
        offLabel.textAlignment = NSTextAlignment.center
        offLabel.textColor = UIColor.lightGray
        offLabel.font = UIFont.systemFont(ofSize: 12)
        backgroundView.addSubview(offLabel)
        
        // thumb
        self.thumbView = UIView(frame: CGRect(x: 1, y: 1, width: self.frame.size.height - 2, height: self.frame.size.height - 2))
        thumbView.backgroundColor = self.thumbTintColor
        thumbView.layer.cornerRadius = (self.frame.size.height * 0.5) - 1
        thumbView.layer.shadowColor = self.shadowColor.cgColor
        thumbView.layer.shadowRadius = 2.0
        thumbView.layer.shadowOpacity = 0.5
        thumbView.layer.shadowOffset = CGSize(width: 0, height: 3)
        thumbView.layer.shadowPath = UIBezierPath(roundedRect: thumbView.bounds, cornerRadius: thumbView.layer.cornerRadius).cgPath
        thumbView.layer.masksToBounds = false
        thumbView.isUserInteractionEnabled = false
        self.addSubview(thumbView)
        
        // thumb image
        self.thumbImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: thumbView.frame.size.width, height: thumbView.frame.size.height))
        thumbImageView.contentMode = UIView.ContentMode.center
        thumbImageView.autoresizingMask = UIView.AutoresizingMask.flexibleWidth
        thumbView.addSubview(thumbImageView)
    
        self.on = false
    }
    
    override open func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        super.beginTracking(touch, with: event)
        
        startTrackingValue = self.on
        didChangeWhileTracking = false
        
        let activeKnobWidth = self.bounds.size.height - 2 + 5
        isAnimating = true
        
        UIView.animate(withDuration: 0.3, delay: 0.0, options: [UIView.AnimationOptions.curveEaseOut, UIView.AnimationOptions.beginFromCurrentState], animations: {
                if self.on {
                    self.thumbView.frame = CGRect(x: self.bounds.size.width - (activeKnobWidth + 1), y: self.thumbView.frame.origin.y, width: activeKnobWidth, height: self.thumbView.frame.size.height)
                    self.backgroundView.backgroundColor = self.onTintColor
                    self.thumbView.backgroundColor = self.onThumbTintColor
                }
                else {
                    self.thumbView.frame = CGRect(x: self.thumbView.frame.origin.x, y: self.thumbView.frame.origin.y, width: activeKnobWidth, height: self.thumbView.frame.size.height)
                    self.backgroundView.backgroundColor = self.activeColor
                    self.thumbView.backgroundColor = self.thumbTintColor
                }
            }, completion: { finished in
                self.isAnimating = false
        })
        
        let shadowAnim = CABasicAnimation(keyPath: "shadowPath")
        shadowAnim.duration = 0.3
        shadowAnim.fromValue = thumbView.layer.shadowPath
        shadowAnim.toValue = UIBezierPath(roundedRect: thumbView.bounds, cornerRadius: thumbView.layer.cornerRadius).cgPath
        thumbView.layer.add(shadowAnim, forKey: "shadowPath")
        thumbView.layer.shadowPath = UIBezierPath(roundedRect: thumbView.bounds, cornerRadius: thumbView.layer.cornerRadius).cgPath
        
        return true
    }
    
    override open func continueTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        super.continueTracking(touch, with: event)
        
        // Get touch location
        let lastPoint = touch.location(in: self)
        
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
    
    override open func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        super.endTracking(touch, with: event)

        let previousValue = self.on

        if didChangeWhileTracking {
            self.setOn(currentVisualValue, animated: true)
        }
        else {
            self.setOn(!self.on, animated: true)
        }
        
        if previousValue != self.on {
            self.sendActions(for: UIControl.Event.valueChanged)
        }
    }
    
    override open func cancelTracking(with event: UIEvent?) {
        super.cancelTracking(with: event)
        
        // just animate back to the original value
        if self.on {
            self.showOn(true)
        }
        else {
            self.showOff(true)
        }
    }
    
    override open func layoutSubviews() {
        super.layoutSubviews()
        
        if !isAnimating {
            let frame = self.frame
            
            // background
            backgroundView.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
            backgroundView.layer.cornerRadius = self.isRounded ? frame.size.height * 0.5 : 2
            
            // images
            onImageView.frame = CGRect(x: 0, y: 0, width: frame.size.width - frame.size.height, height: frame.size.height)
            offImageView.frame = CGRect(x: frame.size.height, y: 0, width: frame.size.width - frame.size.height, height: frame.size.height)
            self.onLabel.frame = CGRect(x: 0, y: 0, width: frame.size.width - frame.size.height, height: frame.size.height)
            self.offLabel.frame = CGRect(x: frame.size.height, y: 0, width: frame.size.width - frame.size.height, height: frame.size.height)
            
            // thumb
            let normalKnobWidth = frame.size.height - 2
            if self.on {
                thumbView.frame = CGRect(x: frame.size.width - (normalKnobWidth + 1), y: 1, width: frame.size.height - 2, height: normalKnobWidth)
                thumbImageView.frame = CGRect(x: frame.size.width - normalKnobWidth, y: 0, width: normalKnobWidth, height: normalKnobWidth)
            }
            else {
                thumbView.frame = CGRect(x: 1, y: 1, width: normalKnobWidth, height: normalKnobWidth)
                thumbImageView.frame = CGRect(x: 0, y: 0, width: normalKnobWidth, height: normalKnobWidth)
            }
            
            thumbView.layer.cornerRadius = self.isRounded ? (frame.size.height * 0.5) - 1 : 2
            thumbView.layer.shadowPath = UIBezierPath(roundedRect: thumbView.bounds, cornerRadius: thumbView.layer.cornerRadius).cgPath
        }
    }
    
    /*
    *   Set the state of the switch to on or off, optionally animating the transition.
    */
    open func setOn(_ isOn: Bool, animated: Bool) {
        switchValue = isOn
        
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
    open func isOn() -> Bool {
        return self.on
    }
    
    /*
    *   update the looks of the switch to be in the on position
    *   optionally make it animated
    */
    fileprivate func showOn(_ animated: Bool) {
        let normalKnobWidth = self.bounds.size.height - 2
        let activeKnobWidth = normalKnobWidth + 5
        if animated {
            isAnimating = true
            UIView.animate(withDuration: 0.3, delay: 0.0, options: [UIView.AnimationOptions.curveEaseOut, UIView.AnimationOptions.beginFromCurrentState], animations: {
                if self.isTracking {
                    self.thumbView.frame = CGRect(x: self.bounds.size.width - (activeKnobWidth + 1), y: self.thumbView.frame.origin.y, width: activeKnobWidth, height: self.thumbView.frame.size.height)
                }
                else {
                    self.thumbView.frame = CGRect(x: self.bounds.size.width - (normalKnobWidth + 1), y: self.thumbView.frame.origin.y, width: normalKnobWidth, height: self.thumbView.frame.size.height)
                }
                
                self.backgroundView.backgroundColor = self.onTintColor
                self.backgroundView.layer.borderColor = self.onTintColor.cgColor
                self.thumbView.backgroundColor = self.onThumbTintColor
                self.onImageView.alpha = 1.0
                self.offImageView.alpha = 0
                self.onLabel.alpha = 1.0
                self.offLabel.alpha = 0
            }, completion: { finished in
                self.isAnimating = false
            })
            
            let shadowAnim = CABasicAnimation(keyPath: "shadowPath")
            shadowAnim.duration = 0.3
            shadowAnim.fromValue = thumbView.layer.shadowPath
            shadowAnim.toValue = UIBezierPath(roundedRect: thumbView.bounds, cornerRadius: thumbView.layer.cornerRadius).cgPath
            thumbView.layer.add(shadowAnim, forKey: "shadowPath")
            thumbView.layer.shadowPath = UIBezierPath(roundedRect: thumbView.bounds, cornerRadius: thumbView.layer.cornerRadius).cgPath
        }
        else {
            if self.isTracking {
                thumbView.frame = CGRect(x: self.bounds.size.width - (activeKnobWidth + 1), y: thumbView.frame.origin.y, width: activeKnobWidth, height: thumbView.frame.size.height)
            }
            else {
                thumbView.frame = CGRect(x: self.bounds.size.width - (normalKnobWidth + 1), y: thumbView.frame.origin.y, width: normalKnobWidth, height: thumbView.frame.size.height)
            }
            
            backgroundView.backgroundColor = self.onTintColor
            backgroundView.layer.borderColor = self.onTintColor.cgColor
            thumbView.backgroundColor = self.onThumbTintColor
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
    fileprivate func showOff(_ animated: Bool) {
        let normalKnobWidth = self.bounds.size.height - 2
        let activeKnobWidth = normalKnobWidth + 5
        
        if animated {
            isAnimating = true
            UIView.animate(withDuration: 0.3, delay: 0.0, options: [UIView.AnimationOptions.curveEaseOut, UIView.AnimationOptions.beginFromCurrentState], animations: {
                if self.isTracking {
                    self.thumbView.frame = CGRect(x: 1, y: self.thumbView.frame.origin.y, width: activeKnobWidth, height: self.thumbView.frame.size.height);
                    self.backgroundView.backgroundColor = self.activeColor
                }
                else {
                    self.thumbView.frame = CGRect(x: 1, y: self.thumbView.frame.origin.y, width: normalKnobWidth, height: self.thumbView.frame.size.height);
                    self.backgroundView.backgroundColor = self.inactiveColor
                }
                
                self.backgroundView.layer.borderColor = self.borderColor.cgColor
                self.thumbView.backgroundColor = self.thumbTintColor
                self.onImageView.alpha = 0
                self.offImageView.alpha = 1.0
                self.onLabel.alpha = 0
                self.offLabel.alpha = 1.0
                
            }, completion: { finished in
                self.isAnimating = false
            })
            
            let shadowAnim = CABasicAnimation(keyPath: "shadowPath")
            shadowAnim.duration = 0.3
            shadowAnim.fromValue = thumbView.layer.shadowPath
            shadowAnim.toValue = UIBezierPath(roundedRect: thumbView.bounds, cornerRadius: thumbView.layer.cornerRadius).cgPath
            thumbView.layer.add(shadowAnim, forKey: "shadowPath")
            thumbView.layer.shadowPath = UIBezierPath(roundedRect: thumbView.bounds, cornerRadius: thumbView.layer.cornerRadius).cgPath
        }
        else {
            if (self.isTracking) {
                thumbView.frame = CGRect(x: 1, y: thumbView.frame.origin.y, width: activeKnobWidth, height: thumbView.frame.size.height)
                backgroundView.backgroundColor = self.activeColor
            }
            else {
                thumbView.frame = CGRect(x: 1, y: thumbView.frame.origin.y, width: normalKnobWidth, height: thumbView.frame.size.height)
                backgroundView.backgroundColor = self.inactiveColor
            }
            backgroundView.layer.borderColor = self.borderColor.cgColor
            thumbView.backgroundColor = self.thumbTintColor
            onImageView.alpha = 0
            offImageView.alpha = 1.0
            onLabel.alpha = 0
            offLabel.alpha = 1.0
        }
        
        currentVisualValue = false
    }
    
    
}

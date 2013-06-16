//
//  SevenSwitch
//
//  Created by Benjamin Vogelzang on 6/10/13.
//  Copyright (c) 2013 Ben Vogelzang. All rights reserved.
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

#import "SevenSwitch.h"
#import <QuartzCore/QuartzCore.h>

@interface SevenSwitch ()  {
    UIView *background;
    UIView *knob;
    double startTime;
}

- (void)showOn:(BOOL)animated;
- (void)showOff:(BOOL)animated;

@end


@implementation SevenSwitch

@synthesize inactiveColor, activeColor, onColor, borderColor, knobColor, shadowColor, on;

- (id)initWithFrame:(CGRect)frame
{
    // use the default values if zero rect frame is set
    CGRect initialFrame;
    if (CGRectIsEmpty(frame)) {
        initialFrame = CGRectMake(0, 0, 50, 30);
    }
    else {
        initialFrame = CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height);
    }
    self = [super initWithFrame:initialFrame];
    if (self) {

        // default colors
        self.on = NO;
        self.inactiveColor = [UIColor clearColor];
        self.activeColor = [UIColor colorWithRed:0.89f green:0.89f blue:0.89f alpha:1.00f];
        self.onColor = [UIColor colorWithRed:0.30f green:0.85f blue:0.39f alpha:1.00f];
        self.borderColor = [UIColor colorWithRed:0.89f green:0.89f blue:0.91f alpha:1.00f];
        self.knobColor = [UIColor whiteColor];
        self.shadowColor = [UIColor grayColor];

        // background
        background = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        background.backgroundColor = [UIColor clearColor];
        background.layer.cornerRadius = self.frame.size.height * 0.5;
        background.layer.borderColor = self.borderColor.CGColor;
        background.layer.borderWidth = 1.0;
        background.userInteractionEnabled = NO;
        [self addSubview:background];

        // knob
        knob = [[UIView alloc] initWithFrame:CGRectMake(1, 1, self.frame.size.height - 2, self.frame.size.height - 2)];
        knob.backgroundColor = self.knobColor;
        knob.layer.cornerRadius = (self.frame.size.height * 0.5) - 1;
        knob.layer.shadowColor = self.shadowColor.CGColor;
        knob.layer.shadowRadius = 2.0;
        knob.layer.shadowOpacity = 0.5;
        knob.layer.shadowOffset = CGSizeMake(0, 3);
        knob.layer.masksToBounds = NO;
        knob.userInteractionEnabled = NO;
        [self addSubview:knob];
    }
    return self;
}

- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    [super beginTrackingWithTouch:touch withEvent:event];

    // start timer to detect tap later in endTrackingWithTouch:withEvent:
    startTime = [[NSDate date] timeIntervalSince1970];

    // make the knob larger and animate to the correct color
    CGFloat activeKnobWidth = self.bounds.size.height - 2 + 5;
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        if (self.on) {
            knob.frame = CGRectMake(self.bounds.size.width - (activeKnobWidth + 1), knob.frame.origin.y, activeKnobWidth, knob.frame.size.height);
            background.backgroundColor = self.onColor;
        }
        else {
            knob.frame = CGRectMake(knob.frame.origin.x, knob.frame.origin.y, activeKnobWidth, knob.frame.size.height);
            background.backgroundColor = self.activeColor;
        }
    } completion:nil];

    return YES;
}

- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    [super continueTrackingWithTouch:touch withEvent:event];

    // Get touch location
    CGPoint lastPoint = [touch locationInView:self];

    // update the switch to the correct visuals depending on if
    // they moved their touch to the right or left side of the switch
    if (lastPoint.x > self.bounds.size.width * 0.5)
        [self showOn:YES];
    else
        [self showOff:YES];

    return YES;
}

- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    [super endTrackingWithTouch:touch withEvent:event];

    // capture time to see if this was a tap action
    double endTime = [[NSDate date] timeIntervalSince1970];
    double difference = endTime - startTime;

    // determine if the user tapped the switch or has held it for longer
    if (difference <= 0.2) {
        CGFloat normalKnobWidth = self.bounds.size.height - 2;
        knob.frame = CGRectMake(knob.frame.origin.x, knob.frame.origin.y, normalKnobWidth, knob.frame.size.height);
        [self setOn:!self.on animated:YES];
    }
    else {
        // Get touch location
        CGPoint lastPoint = [touch locationInView:self];

        // update the switch to the correct value depending on if
        // their touch finished on the right or left side of the switch
        if (lastPoint.x > self.bounds.size.width * 0.5)
            [self setOn:YES animated:YES];
        else
            [self setOn:NO animated:YES];
    }
}

- (void)cancelTrackingWithEvent:(UIEvent *)event {
    [super cancelTrackingWithEvent:event];

    // just animate back to the original value
    if (self.on)
        [self showOn:YES];
    else
        [self showOff:YES];
}


- (void)setFrame:(CGRect)frame {
    self.bounds = CGRectMake(0, 0, frame.size.width, frame.size.height);
    self.center = CGPointMake(frame.origin.x + frame.size.width * 0.5, frame.origin.y + frame.size.height * 0.5);
    
    // background
    background.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    background.layer.cornerRadius = frame.size.height * 0.5;
    
    // knob
    knob.frame = CGRectMake(1, 1, frame.size.height - 2, frame.size.height - 2);
    knob.layer.cornerRadius = (frame.size.height * 0.5) - 1;
}

- (void)setInactiveColor:(UIColor *)color {
    inactiveColor = color;
    if (!self.on && !self.isTracking)
        background.backgroundColor = color;
}

- (void)setOnColor:(UIColor *)color {
    onColor = color;
    if (self.on && !self.isTracking)
        background.backgroundColor = color;
}

- (void)setBorderColor:(UIColor *)color {
    borderColor = color;
    if (!self.on)
        background.layer.borderColor = color.CGColor;
}

- (void)setKnobColor:(UIColor *)color {
    knobColor = color;
    knob.backgroundColor = color;
}

- (void)setShadowColor:(UIColor *)color {
    shadowColor = color;
    knob.layer.shadowColor = color.CGColor;
}

/*
 * set (without animation) whether the switch is ON or OFF
 */
- (void)setOn:(BOOL)isOn {
    [self setOn:isOn animated:NO];
}


/*
 * Set the state of the switch to On or Off, optionally animating the transition.
 */
- (void)setOn:(BOOL)isOn animated:(BOOL)animated {
    BOOL previousValue = self.on;
    on = isOn;
    
    if (previousValue != isOn)
        [self sendActionsForControlEvents:UIControlEventValueChanged];

    if (isOn) {
        [self showOn:animated];
    }
    else {
        [self showOff:animated];
    }
}


/*
 * update the looks of the switch to be in the ON position
 * optionally make it animated
 */
- (void)showOn:(BOOL)animated {
    CGFloat normalKnobWidth = self.bounds.size.height - 2;
    CGFloat activeKnobWidth = normalKnobWidth + 5;
    if (animated) {
        [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            if (self.tracking)
                knob.frame = CGRectMake(self.bounds.size.width - (activeKnobWidth + 1), knob.frame.origin.y, activeKnobWidth, knob.frame.size.height);
            else
                knob.frame = CGRectMake(self.bounds.size.width - (normalKnobWidth + 1), knob.frame.origin.y, normalKnobWidth, knob.frame.size.height);
            background.backgroundColor = self.onColor;
            background.layer.borderColor = self.onColor.CGColor;
        } completion:nil];
    }
    else {
        if (self.tracking)
            knob.frame = CGRectMake(self.bounds.size.width - (activeKnobWidth + 1), knob.frame.origin.y, activeKnobWidth, knob.frame.size.height);
        else
            knob.frame = CGRectMake(self.bounds.size.width - (normalKnobWidth + 1), knob.frame.origin.y, normalKnobWidth, knob.frame.size.height);
        background.backgroundColor = self.onColor;
        background.layer.borderColor = self.onColor.CGColor;
    }
}


/*
 * update the looks of the switch to be in the OFF position
 * optionally make it animated
 */
- (void)showOff:(BOOL)animated {
    CGFloat normalKnobWidth = self.bounds.size.height - 2;
    CGFloat activeKnobWidth = normalKnobWidth + 5;
    if (animated) {
        [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            if (self.tracking) {
                knob.frame = CGRectMake(1, knob.frame.origin.y, activeKnobWidth, knob.frame.size.height);
                background.backgroundColor = self.activeColor;
            }
            else {
                knob.frame = CGRectMake(1, knob.frame.origin.y, normalKnobWidth, knob.frame.size.height);
                background.backgroundColor = self.inactiveColor;
            }
            background.layer.borderColor = self.borderColor.CGColor;
        } completion:nil];
    }
    else {
        if (self.tracking) {
            knob.frame = CGRectMake(1, knob.frame.origin.y, activeKnobWidth, knob.frame.size.height);
            background.backgroundColor = self.activeColor;
        }
        else {
            knob.frame = CGRectMake(1, knob.frame.origin.y, normalKnobWidth, knob.frame.size.height);
            background.backgroundColor = self.inactiveColor;
        }
    }
}

@end

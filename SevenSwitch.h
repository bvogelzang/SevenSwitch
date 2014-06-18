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

#import <UIKit/UIKit.h>

@interface SevenSwitch : UIControl

/*
 * Set (without animation) whether the switch is on or off
 */
@property (nonatomic, assign) BOOL on;


/*
 *	Sets the background color when the switch is off.
 *  Defaults to clear color.
 */
@property (nonatomic, strong) UIColor *inactiveColor;

/*
 *	Sets the background color that shows when the switch off and actively being touched.
 *  Defaults to light gray.
 */
@property (nonatomic, strong) UIColor *activeColor;

/*
 *	Sets the background color that shows when the switch is on.
 *  Defaults to green.
 */
@property (nonatomic, strong) UIColor *onTintColor;
@property (nonatomic, strong) UIColor *onColor __deprecated;

/*
 *	Sets the border color that shows when the switch is off. Defaults to light gray.
 */
@property (nonatomic, strong) UIColor *borderColor;

/*
 *	Sets the knob color. Defaults to white.
 */
@property (nonatomic, strong) UIColor *thumbTintColor;
@property (nonatomic, strong) UIColor *onThumbTintColor;
@property (nonatomic, strong) UIColor *knobColor __deprecated;

/*
 *	Sets the shadow color of the knob. Defaults to gray.
 */
@property (nonatomic, strong) UIColor *shadowColor;


/*
 *	Sets whether or not the switch edges are rounded.
 *  Set to NO to get a stylish square switch.
 *  Defaults to YES.
 */
@property (nonatomic, assign) BOOL isRounded;


/*
 *  Sets the image that shows on the switch thumb.
 */
@property (nonatomic, strong) UIImage *thumbImage;


/*
 *	Sets the image that shows when the switch is on.
 *  The image is centered in the area not covered by the knob.
 *  Make sure to size your images appropriately.
 */
@property (nonatomic, strong) UIImage *onImage;

/*
 *	Sets the image that shows when the switch is off.
 *  The image is centered in the area not covered by the knob.
 *  Make sure to size your images appropriately.
 */
@property (nonatomic, strong) UIImage *offImage;

/*
 *	Sets the text that shows when the switch is off.
 *  The text is centered in the area not covered by the knob.
 */
@property (nonatomic, strong) UILabel *offLabel;

/*
 *	Sets the text that shows when the switch is on.
 *  The text is centered in the area not covered by the knob.
 */
@property (nonatomic, strong) UILabel *onLabel;

/*
 * Set whether the switch is on or off. Optionally animate the change
 */
- (void)setOn:(BOOL)on animated:(BOOL)animated;

/*
 *	Detects whether the switch is on or off
 *
 *	@return	BOOL YES if switch is on. NO if switch is off
 */
- (BOOL)isOn;

@end

//
//  ViewController.m
//  SevenSwitchExample
//
//  Created by Benjamin Vogelzang on 6/15/13.
//  Copyright (c) 2013 Ben Vogelzang. All rights reserved.
//

#import "ViewController.h"
#import "SevenSwitch.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // this will create the switch with default dimensions, you'll still need to set the position though
    // you also have the option to pass in a frame of any size you choose
    SevenSwitch *mySwitch = [[SevenSwitch alloc] initWithFrame:CGRectZero];
    mySwitch.center = CGPointMake(self.view.bounds.size.width * 0.5, self.view.bounds.size.height * 0.5);
    
// Example of a bigger switch. Uncomment to see it in action
//    CGFloat switchWidth = 100;
//    CGFloat switchHeight = 50;
//    mySwitch.frame = CGRectMake((self.view.bounds.size.width * 0.5) - (switchWidth * 0.5), (self.view.bounds.size.height * 0.5) - (switchHeight * 0.5), switchWidth, switchHeight);
    
    [mySwitch addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:mySwitch];
    
// Example of color customization
// Uncomment if you want to set the switch to a darker style
//    self.view.backgroundColor = [UIColor colorWithRed:0.19f green:0.23f blue:0.33f alpha:1.00f];
//    mySwitch.knobColor = [UIColor colorWithRed:0.19f green:0.23f blue:0.33f alpha:1.00f];
//    mySwitch.activeColor = [UIColor colorWithRed:0.07f green:0.09f blue:0.11f alpha:1.00f];
//    mySwitch.inactiveColor = [UIColor colorWithRed:0.07f green:0.09f blue:0.11f alpha:1.00f];
//    mySwitch.onColor = [UIColor colorWithRed:0.45f green:0.58f blue:0.67f alpha:1.00f];
//    mySwitch.borderColor = [UIColor clearColor];
//    mySwitch.shadowColor = [UIColor blackColor];
}

- (void)switchChanged:(SevenSwitch *)sender {
    NSLog(@"Changed value to: %@", sender.on ? @"ON" : @"OFF");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  ViewController.m
//  SevenSwitchExample
//
//  Created by Benjamin Vogelzang on 6/15/13.
//  Copyright (c) 2013 Ben Vogelzang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize ibSwitch;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    ibSwitch.onTintColor = [UIColor colorWithRed:0.20f green:0.42f blue:0.86f alpha:1.00f];
    ibSwitch.on = YES;
	
	
    // this will create the switch with default dimensions, you'll still need to set the position though
    // you also have the option to pass in a frame of any size you choose
    SevenSwitch *mySwitch = [[SevenSwitch alloc] initWithFrame:CGRectZero];
    mySwitch.center = CGPointMake(self.view.bounds.size.width * 0.5, self.view.bounds.size.height * 0.5);
    [mySwitch addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:mySwitch];

    // turn the switch on
    mySwitch.on = YES;
    
    // Example of a bigger switch with images
    SevenSwitch *mySwitch2 = [[SevenSwitch alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
    mySwitch2.center = CGPointMake(self.view.bounds.size.width * 0.5, self.view.bounds.size.height * 0.5 - 80);
    [mySwitch2 addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
    mySwitch2.offImage = [UIImage imageNamed:@"cross.png"];
    mySwitch2.onImage = [UIImage imageNamed:@"check.png"];
    mySwitch2.onTintColor = [UIColor colorWithHue:0.08f saturation:0.74f brightness:1.00f alpha:1.00f];
    mySwitch2.isRounded = NO;
    [self.view addSubview:mySwitch2];
    
    // turn the switch on with animation
    [mySwitch2 setOn:YES animated:YES];
    
    // Example of color customization
    SevenSwitch *mySwitch3 = [[SevenSwitch alloc] initWithFrame:CGRectZero];
    mySwitch3.center = CGPointMake(self.view.bounds.size.width * 0.5, self.view.bounds.size.height * 0.5 + 70);
    [mySwitch3 addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:mySwitch3];
    
    //self.view.backgroundColor = [UIColor colorWithRed:0.19f green:0.23f blue:0.33f alpha:1.00f];
    mySwitch3.thumbTintColor = [UIColor colorWithRed:0.19f green:0.23f blue:0.33f alpha:1.00f];
    mySwitch3.activeColor = [UIColor colorWithRed:0.07f green:0.09f blue:0.11f alpha:1.00f];
    mySwitch3.inactiveColor = [UIColor colorWithRed:0.07f green:0.09f blue:0.11f alpha:1.00f];
    mySwitch3.onTintColor = [UIColor colorWithRed:0.45f green:0.58f blue:0.67f alpha:1.00f];
    mySwitch3.borderColor = [UIColor clearColor];
    mySwitch3.shadowColor = [UIColor blackColor];
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

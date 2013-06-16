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
	// Do any additional setup after loading the view, typically from a nib.
    
    
    SevenSwitch *mySwitch = [[SevenSwitch alloc] initWithFrame:CGRectMake(self.view.bounds.size.width * 0.5 - 25, self.view.bounds.size.height * 0.5 - 15, 0, 0)];
    [mySwitch addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:mySwitch];
    

//    // Example of customiztion
//    // Use this if you want to set the switch to a darker style
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

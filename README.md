## SevenSwitch

iOS7 style drop in replacement for UISwitch

![Animation](https://raw.github.com/bvogelzang/SevenSwitch/master/ExampleImages/example.gif)

![Default](https://raw.github.com/bvogelzang/SevenSwitch/master/ExampleImages/example.png)

## Usage

To use it, add SevenSwitch.h and SevenSwitch.m files to your project and add the QuartzCore framework to your project.

Initializing and adding the switch to the screen

```objective-c
SevenSwitch *mySwitch = [[SevenSwitch alloc] initWithFrame:CGRectMake(10, 10, 50, 30)];
[self.view addSubview:mySwitch];
```

When the user manipulates the switch control ("flips" it) a `UIControlEventValueChanged` event is generated.

```objective-c
[mySwitch addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
```

You can set images for the on/off states

```objective-c
mySwitch.offImage = [UIImage imageNamed:@"cross.png"];
mySwitch.onImage = [UIImage imageNamed:@"check.png"];
```

You can also customize the switches colors

```objective-c
mySwitch.thumbTintColor = [UIColor colorWithRed:0.19f green:0.23f blue:0.33f alpha:1.00f];
mySwitch.activeColor = [UIColor colorWithRed:0.07f green:0.09f blue:0.11f alpha:1.00f];
mySwitch.inactiveColor = [UIColor colorWithRed:0.07f green:0.09f blue:0.11f alpha:1.00f];
mySwitch.onTintColor = [UIColor colorWithRed:0.45f green:0.58f blue:0.67f alpha:1.00f];
mySwitch.borderColor = [UIColor clearColor];
mySwitch.shadowColor = [UIColor blackColor];
```

You can resize the switch frame to whatever you like to make fatter/skinnier controls

```objective-c
mySwitch.frame = CGRectMake(0, 0, 100, 50);
```

You can turn off the rounded look by setting the `isRounded` property to `NO`

```objective-c
mySwitch.isRounded = NO;
```

## Requirements

SevenSwitch requires iOS 5.0 and above.

#### ARC

SevenSwitch uses ARC as of its 1.0 release.

## License

Made available under the MIT License. Attribution would be nice.

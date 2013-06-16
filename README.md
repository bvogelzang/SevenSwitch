## SevenSwitch

iOS 7 style drop in replacement for UISwitch

![Animation](https://raw.github.com/bvogelzang/SevenSwitch/master/example.gif)
![Default](https://raw.github.com/bvogelzang/SevenSwitch/master/example.png)
![Custom](https://raw.github.com/bvogelzang/SevenSwitch/master/example2.png)
![Custom Dark](https://raw.github.com/bvogelzang/SevenSwitch/master/example3.png)

## Usage

Initializing and adding the switch to the screen

```objective-c
SevenSwitch *mySwitch = [[SevenSwitch alloc] initWithFrame:CGRectMake(10, 10, 0, 0)];
[self.view addSubview:mySwitch];
```

When the user manipulates the switch control ("flips" it) a `UIControlEventValueChanged` event is generated.

```objective-c
[mySwitch addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
```

You can also customize the switches colors

```objective-c
mySwitch.knobColor = [UIColor colorWithRed:0.19f green:0.23f blue:0.33f alpha:1.00f];
mySwitch.activeColor = [UIColor colorWithRed:0.07f green:0.09f blue:0.11f alpha:1.00f];
mySwitch.inactiveColor = [UIColor colorWithRed:0.07f green:0.09f blue:0.11f alpha:1.00f];
mySwitch.onColor = [UIColor colorWithRed:0.45f green:0.58f blue:0.67f alpha:1.00f];
mySwitch.borderColor = [UIColor clearColor];
mySwitch.shadowColor = [UIColor blackColor];
```

## Requirements

SevenSwitch requires iOS 5.0 and above.

#### ARC

SevenSwitch uses ARC as of its 1.0 release.

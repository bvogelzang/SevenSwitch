## SevenSwitch

iOS 7 style drop in replacement for UISwitch

![Animation](https://raw.github.com/bvogelzang/SevenSwitch/master/example.gif)
![Default](https://raw.github.com/bvogelzang/SevenSwitch/master/example.png)
![Custom](https://raw.github.com/bvogelzang/SevenSwitch/master/example2.png)

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
mySwitch.inactiveColor = [UIColor darkGrayColor];
mySwitch.activeColor = [UIColor greenColor];
mySwitch.onColor = [UIColor blueColor];
mySwitch.knobColor = [UIColor redColor];
mySwitch.borderColor = [UIColor blackColor];
```

## Requirements

SevenSwitch requires iOS 5.0 and above.

#### ARC

SevenSwitch uses ARC as of its 1.0 release.

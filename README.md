## SevenSwitch

iOS 7 style drop in replacement for UISwitch

![Default](https://raw.github.com/bvogelzang/SevenSwitch/master/example.png)
![Custom](https://raw.github.com/bvogelzang/SevenSwitch/master/example2.png)

## Usage

Initializing and adding the switch to the screen

```objective-c
SevenSwitch *mySwitch = [[SevenSwitch alloc] initWithFrame:CGRectMake(10, 10, 0, 0)];
[mySwitch addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
[self.view addSubview:mySwitch];
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

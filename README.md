## SevenSwitch

iOS7 style drop in replacement for UISwitch

![Animation](https://raw.github.com/bvogelzang/SevenSwitch/master/ExampleImages/example.gif)

![Default](https://raw.github.com/bvogelzang/SevenSwitch/master/ExampleImages/example.png)

## Usage

### Cocoapods

```
pod 'SevenSwitch', '~> 2.0'
```

*Swift support was added in version `2.0`. If your project does not support swift you can use `1.4`.*

### Without Cocoapods

Add `SevenSwitch.swift` to your project and add the `QuartzCore` framework to your project.

### Examples

Initializing and adding the switch to the screen

```swift
let mySwitch = SevenSwitch()
self.view.addSubview(mySwitch)
```

When the user manipulates the switch control ("flips" it) a `UIControlEvent.ValueChanged` event is generated.

```swift
mySwitch.addTarget(self, action: "switchChanged:", forControlEvents: UIControlEvents.ValueChanged)
```

You can set images for the on/off states

```swift
mySwitch.offImage = UIImage(named: "cross.png")
mySwitch.onImage = UIImage(named: "check.png")
mySwitch.thumbImage = UIImage(named: "thumb.png")
```

You can set text for the on/off states

```swift
mySwitch.offLabel.text = "ON"
mySwitch.onLabel.text = "OFF"
```

You can also customize the switches colors

```swift
mySwitch.thumbTintColor = UIColor(red: 0.19, green: 0.23, blue: 0.33, alpha: 1)
mySwitch.activeColor =  UIColor(red: 0.07, green: 0.09, blue: 0.11, alpha: 1)
mySwitch.inactiveColor =  UIColor(red: 0.07, green: 0.09, blue: 0.11, alpha: 1)
mySwitch.onTintColor =  UIColor(red: 0.45, green: 0.58, blue: 0.67, alpha: 1)
mySwitch.borderColor = UIColor.clearColor()
mySwitch.shadowColor = UIColor.blackColor()
```

You can resize the switch frame to whatever you like to make fatter/skinnier controls

```swift
mySwitch.frame = CGRectMake(0, 0, 100, 50)
```

You can turn off the rounded look by setting the `isRounded` property to `NO`

```swift
mySwitch.isRounded = false
```

## Swift and Objective-C compatability

SevenSwitch uses Swift as of its 2.0 release. SevenSwitch.swift can be used in Objective-C. See [ViewController.m](SevenSwitchExample/SevenSwitchExample/ViewController.m) for an example.

## Requirements

SevenSwitch requires iOS 5.0 and above.

#### ARC

SevenSwitch uses ARC as of its 1.0 release.

## License

Made available under the MIT License. Attribution would be nice.

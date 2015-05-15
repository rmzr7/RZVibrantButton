RZVibrantButton
===============

RZVibrantButton is a stylish button with iOS 8 vibrancy effect built using Swift. It is a subclass of `UIButton` that has a simple yet elegant appearance and built-in support for `UIVisualEffectView` and `UIVibrancyEffect` classes introduced in iOS 8. Yet, it can be used on iOS 7 without the vibrancy effect. The design of this button is inspired by "AYVibrantButton" by alan yip.

![Screenshot](https://github.com/a1anyip/AYVibrantButton/blob/master/Readme/screenshot.png?raw=true)

[![CI Status](http://img.shields.io/travis/remzr7/RZVibrantButton.svg?style=flat)](https://travis-ci.org/remzr7/RZVibrantButton)
[![Version](https://img.shields.io/cocoapods/v/RZVibrantButton.svg?style=flat)](http://cocoapods.org/pods/RZVibrantButton)
[![License](https://img.shields.io/cocoapods/l/RZVibrantButton.svg?style=flat)](http://cocoapods.org/pods/RZVibrantButton)
[![Platform](https://img.shields.io/cocoapods/p/RZVibrantButton.svg?style=flat)](http://cocoapods.org/pods/RZVibrantButton)

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Configurations

Vibrant buttons can be configured with one of the three supported button styles, **invert**, **translucent** and **fill** (see examples below).

Some basic properties like **icon**, **text**, **font**, **alpha**, **corner radius**, **border width** and **background color** (for no vibrancy effect) can all be changed easily.

The default vibrancy effect is for blur effect `UIBlurEffectStyleLight`. It could be set to any `UIVibrancyEffect` instance. For today extensions, it should be set to `[UIVibrancyEffect notificationCenterVibrancyEffect]`.

## Note

Though vibrant buttons can be placed anywhere, it is recommended that vibrant buttons with vibrancy effects should be placed in the `contentView` of `UIVisualEffectView` (except in today view).

`UIVisualEffectView` can be created as follows.

```swift
var effectView:UIVisualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffectStyle.ExtraLight))
effectView.frame = self.view.bounds;
self.view.addSubview(effectView)
```

## Examples

The following images show the normal and highlighted (being pressed) button appearances.

### Invert style with vibrancy effect

![Invert Dark](https://github.com/a1anyip/AYVibrantButton/blob/master/Readme/invert2-dark.gif?raw=true)
![Invert Extra Light](https://github.com/a1anyip/AYVibrantButton/blob/master/Readme/invert2-extralight.gif?raw=true)

![Invert Dark](https://github.com/a1anyip/AYVibrantButton/blob/master/Readme/invert-dark.gif?raw=true)
![Invert Extra Light](https://github.com/a1anyip/AYVibrantButton/blob/master/Readme/invert-extralight.gif?raw=true)

````swift
var invertButton:RZVibrantButton = RZVibrantButton(frame:CGRectZero, style:RZVibrantButtonStyle.Invert)
invertButton.vibrancyEffect = UIVibrancyEffect(forBlurEffect: UIBlurEffect(style: UIBlurEffectStyle.ExtraLight))
invertButton.text = "Invert"
invertButton.font = UIFont.systemFontOfSize(18.0)
effectView.contentView.addSubview(invertButton)
```

### Translucent style with vibrancy effect

![Translucent Dark](https://github.com/a1anyip/AYVibrantButton/blob/master/Readme/translucent-dark.gif?raw=true)
![Translucent Extra Light](https://github.com/a1anyip/AYVibrantButton/blob/master/Readme/translucent-extralight.gif?raw=true)

````swift
var translucentButton:RZVibrantButton = RZVibrantButton(frame:CGRectZero, style:RZVibrantButtonStyle.Translucent)
translucentButton.vibrancyEffect = UIVibrancyEffect(forBlurEffect: UIBlurEffect(style: UIBlurEffectStyle.ExtraLight))
translucentButton.text = "Translucent";
translucentButton.font = UIFont.systemFontOfSize(18.0)
effectView.contentView.addSubview(translucentButton)
```

### Translucent style without vibrancy effect

![Translucent Dark](https://github.com/a1anyip/AYVibrantButton/blob/master/Readme/anycolor-dark.gif?raw=true)
![Translucent Extra Light](https://github.com/a1anyip/AYVibrantButton/blob/master/Readme/anycolor-extralight.gif?raw=true)

````swift
var button:RZVibrantButton = RZVibrantButton(frame:CGRectZero, style:RZVibrantButtonStyle.Translucent)
button.vibrancyEffect = nil;
button.text = "Any Color";
button.font = UIFont.systemFontOfSize(18.0)
button.backgroundColor = UIColor.blackColor()
effectView.contentView.addSubview(button)
```

## Installation

RZVibrantButton is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "RZVibrantButton"
```


### Manual Installation

Simply add `RZVibrantButton.swift` to your project.

## License

The MIT License (MIT)

Copyright (c) 2015 Rameez Remsudeen, Abdulla Contractor and Alan Yip

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

# SwiftyStars

SwiftyStars is a star rating control for iOS written in Swift 5.0.


# Features

- [x] Show a rating by setting the current rate
- [x] Allow users to rate by tapping a star
- [x] Haptic feedback generation upon taps
- [x] Stars are fully customizable
- [x] Control can be setup from Interface Builder, by passing a frame or by adding constraints via code

# Requirements

- iOS 11.0+
- Xcode 11+


# Installation

## Cocoapods

You can use Cocoapods to install `SwiftStars` by adding it to your Podfile:

`pod SwiftyStars`

# Usage Example

1. Storyboards: Drop a UIView and set its class to StarsView. The color, number of stars and spacing between stars can be
adjusted from IB.

2. Initiating an instance and passing a frame:
```
import StarsView
let starsView = StarsView(frame: .init(x: 0, y: 0, width: 200, height: 50)
starsView.numberOfStars = 5
starsView.starColor = .red
```

3. Adding view using autlayout from code:

```
starsView.translatedAutoLayoutMasksToConstraints = false
NSLayouConstraing.activate([
    starsView.topAnchor.constraint(equalTo: view.safeAreaLayout.topAnchor, constant: 20),
    ...
])


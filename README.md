# PHOTPView

Fully Customized pin code(OTP) verification view without storyboard.


## Getting Started

### Features :

- Flawless focus change to the consecutive OTP box when the text is entered/deleted.
- When the user taps on the Pinview, the first empty box available is focused automatically (when the cursor is hidden).
- Customisations are available for pin box sizes, font color, border color, inputType etc.

### Installation

download project for quick demo.

Manually :

- Copy and drag the PHOTPView/ folder to your project.

### How to Use?

- create a PHOTPView object

```sh
var otpView: PHOTPView!

```

- create a PinConfig object 

```sh
var config : PinConfig = PinConfig()
```

responsible for all kind of customization
#### Example

```sh
config.otpFieldDisplayType = .square
config.shouldAllowIntermediateEditing = false
config.otpFieldDefaultBorderColor = UIColor.blue
config.otpFieldEnteredBorderColor = UIColor.green
config.otpFieldErrorBorderColor = UIColor.red
```
     
- initialize view by assigning cofig object  

```sh
 otpView = PHOTPView(config: config)
 otpView.delegate = self
 ```

- assign delegate 

```sh
 otpView.delegate = self
 ```
 
- Finally, Add to your view in which you want to configure OTPview
```sh
self.view.addSubview(otpView)
 ```
 
# Prerequisites
- xcode 9
- swift 5



License
----

MIT

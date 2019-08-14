//
//  PHOTPConfig.swift
//  PHOTPView
//  Version 1.0
//
//  Created by Pankti Patel on 2019-08-13.
//  Copyright © 2019 Pankti Patel. All rights reserved.
//

import Foundation
import UIKit


/// Different display type for text fields.
public enum DisplayType
{
    case circular
    case square
    case diamond
    case underlinedBottom
}

/// Different input type for OTP fields.
public enum KeyboardType: Int
{
    case numeric
    case alphabet
    case alphaNumeric
}

public struct PinConfig
{
    
    /// Define the display type for OTP fields. Defaults to `circular`.
    var otpFieldDisplayType: DisplayType = .circular
    
    /// Defines the number of OTP field needed. Defaults to 4.
    var otpFieldsCount: Int = 4
    
    /// Defines the type of the data that can be entered into OTP fields. Defaults to `numeric`.
    var otpFieldInputType: KeyboardType = .numeric
    
    /// Define the font to be used to OTP field. Defaults tp `systemFont` with size `20`.
    var otpFieldFont: UIFont = UIFont.systemFont(ofSize: 20)
    
    /// If set to `true`, then the content inside OTP field will be displayed in asterisk (*) format. Defaults to `false`.
    var otpFieldEntrySecureType: Bool = false
    
    /// If set to `true`, then the content inside OTP field will not be displayed. Instead whatever was set in `otpFieldEnteredBorderColor` will be used to mask the passcode. If `otpFieldEntrySecureType` is set to `true`, then it'll be ignored. This acts similar to Apple's lock code. Defaults to `false`.
    var otpFilledEntryDisplay: Bool = false
    
    /// If set to `false`, the blinking cursor for OTP field will not be visible. Defaults to `true`.
    var shouldRequireCursor: Bool = true
    
    /// If `shouldRequireCursor` is set to `false`, then this property will not have any effect. If `true`, then the color of cursor can be changed using this property. Defaults to `blue` color.
    var cursorColor: UIColor = UIColor.blue
    
    /// Defines the size of OTP field. Defaults to `60`.
    var otpFieldSize: CGFloat = 60
    
    /// Space between 2 OTP field. Defaults to `16`.
    var otpFieldSeparatorSpace: CGFloat = 16
    
    /// Border width to be used, if border is needed. Defaults to `2`.
    var otpFieldBorderWidth: CGFloat = 2
    
    /// If set, then editing can be done to intermediate fields even though previous fields are empty. Else editing will take place from last filled text field only. Defaults to `true`.
    var shouldAllowIntermediateEditing: Bool = true
    
    /// Set this value if a background color is needed when a text is not enetered in the OTP field. Defaults to `clear` color.
    var otpFieldDefaultBackgroundColor: UIColor = UIColor.clear
    
    /// Set this value if a background color is needed when a text is enetered in the OTP field. Defaults to `clear` color.
    var otpFieldEnteredBackgroundColor: UIColor = UIColor.clear
    
    /// Set this value if a border color is needed when a text is not enetered in the OTP field. Defaults to `black` color.
    var otpFieldDefaultBorderColor: UIColor = UIColor.black
    
    /// Set this value if a border color is needed when a text is enetered in the OTP field. Defaults to `black` color.
    var otpFieldEnteredBorderColor: UIColor = UIColor.black
    
    /// Optional value if a border color is needed when the otp entered is invalid/incorrect.
    var otpFieldErrorBorderColor: UIColor?

    
    init(otpFieldDisplayType: DisplayType = DisplayType.circular,
        otpFieldsCount: Int = 4,
        otpFieldInputType: KeyboardType = KeyboardType.numeric,
        otpFieldFont: UIFont = UIFont.systemFont(ofSize: 20),
        otpFieldEntrySecureType: Bool = false,
        otpFilledEntryDisplay: Bool = false,
        shouldRequireCursor: Bool = true,
        cursorColor: UIColor = UIColor.blue,
        otpFieldSize: CGFloat = 60,
        otpFieldSeparatorSpace: CGFloat = 16,
        otpFieldBorderWidth: CGFloat = 2,
        shouldAllowIntermediateEditing: Bool = true,
        otpFieldDefaultBackgroundColor: UIColor = UIColor.clear,
        otpFieldEnteredBackgroundColor: UIColor = UIColor.clear,
        otpFieldDefaultBorderColor: UIColor = UIColor.black,
        otpFieldEnteredBorderColor: UIColor = UIColor.black,
        otpFieldErrorBorderColor: UIColor = UIColor.red
        )
     {
        
        self.otpFieldDisplayType = otpFieldDisplayType
        self.otpFieldsCount = otpFieldsCount
        self.otpFieldInputType = otpFieldInputType
        self.otpFieldFont = otpFieldFont
        self.otpFieldEntrySecureType = otpFieldEntrySecureType
        self.otpFilledEntryDisplay = otpFilledEntryDisplay
        self.shouldRequireCursor = shouldRequireCursor
        self.cursorColor = cursorColor
        self.otpFieldSize = otpFieldSize
        self.otpFieldSeparatorSpace = otpFieldSeparatorSpace
        self.shouldAllowIntermediateEditing = shouldAllowIntermediateEditing
        self.otpFieldDefaultBackgroundColor = otpFieldDefaultBackgroundColor
        self.otpFieldEnteredBackgroundColor = otpFieldEnteredBackgroundColor
        self.otpFieldDefaultBorderColor = otpFieldDefaultBorderColor
        self.otpFieldEnteredBorderColor = otpFieldEnteredBorderColor
        self.otpFieldErrorBorderColor = otpFieldErrorBorderColor
    }

}

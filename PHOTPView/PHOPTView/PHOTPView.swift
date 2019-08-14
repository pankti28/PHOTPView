//
//  PHOTPView.swift
//  PHOTPView
//  Version 1.0
//
//  Created by Pankti Patel on 2019-08-13.
//  Copyright © 2019 Pankti Patel. All rights reserved.
//

import UIKit

protocol PHOTPViewDelegate: class
{
    /// Called whenever the textfield has to become first responder. Called for the first field when loading
    ///
    /// - Parameter index: the index of the field. Index starts from 0.
    /// - Returns: return true to show keyboard and vice versa
    func shouldBecomeFirstResponderForOTP(otpFieldIndex index: Int) -> Bool
    
    /// Called whenever all the OTP fields have been entered. It'll be called immediately after `hasEnteredAllOTP` delegate method is called.
    ///
    /// - Parameter otpString: The entered otp characters
    func getenteredOTP(otpString: String)
    
    /// Called whenever an OTP is entered.
    ///
    /// - Parameter hasEntered: `hasEntered` will be `true` if all the OTP fields have been filled.
    /// - Returns: return if OTP entered is valid or not. If false and all otp has been entered, then error
    func hasEnteredAllOTP(hasEntered: Bool) -> Bool
    
}

class PHOTPView: UIView
{
    
    public var config : PinConfig! = PinConfig()

    weak var delegate: PHOTPViewDelegate?
    
    fileprivate var secureEntryData = [String]()
    
    convenience init(config:PinConfig = PinConfig())
    {
        self.init()
        self.config         = config
        
    }
    //MARK: Public functions
    /// Call this method to create the OTP field view. This method should be called at the last after necessary customization needed. If any property is modified at a later stage is simply ignored.
    func initializeUI()
    {
        layer.masksToBounds = true
        layoutIfNeeded()
        
        initializeOTPFields()
        
        // make first otp field as first responder
        (viewWithTag(1) as? PHOTPTextField)?.becomeFirstResponder()
    }
    
    //MARK: Private functions
    // Set up the fields
    private func initializeOTPFields()
    {
        secureEntryData.removeAll()
        
        for index in stride(from: 0, to: config.otpFieldsCount, by: 1)
        {
            let oldOtpField = viewWithTag(index + 1) as? PHOTPTextField
            oldOtpField?.removeFromSuperview()
            
            let otpField = getOTPtextField(forIndex: index)
            addSubview(otpField)
            
            secureEntryData.append("")
        }
    }
    
    // Initalize the required OTP fields
    private func getOTPtextField(forIndex index: Int) -> PHOTPTextField
    {
        let hasOddNumberOfFields = (config.otpFieldsCount % 2 == 1)
        var fieldFrame = CGRect(x: 0, y: 0, width: config.otpFieldSize, height: config.otpFieldSize)
        
        // If odd, then center of self will be center of middle field. If false, then center of self will be center of space between 2 middle fields.
        if hasOddNumberOfFields
        {
            // Calculate from middle each fields x and y values so as to align the entire view in center
            fieldFrame.origin.x = bounds.size.width / 2 - (CGFloat(config.otpFieldsCount / 2 - index) * (config.otpFieldSize + config.otpFieldSeparatorSpace) + config.otpFieldSize / 2)
        }
        else
        {
            // Calculate from middle each fields x and y values so as to align the entire view in center
            fieldFrame.origin.x = bounds.size.width / 2 - (CGFloat(config.otpFieldsCount / 2 - index) * config.otpFieldSize + CGFloat(config.otpFieldsCount / 2 - index - 1) * config.otpFieldSeparatorSpace + config.otpFieldSeparatorSpace / 2)
        }
        
        fieldFrame.origin.y = (bounds.size.height - config.otpFieldSize) / 2
        
        let otpField = PHOTPTextField(frame: fieldFrame)
        otpField.delegate = self
        otpField.tag = index + 1
        otpField.font = config.otpFieldFont
        
        // Set input type for OTP fields
        switch config.otpFieldInputType
        {
            case .numeric:
                otpField.keyboardType = .numberPad
            case .alphabet:
                otpField.keyboardType = .alphabet
            case .alphaNumeric:
                otpField.keyboardType = .namePhonePad
        }
        
        // Set the border values if needed
        otpField.borderColor = config.otpFieldDefaultBorderColor
        otpField.borderWidth = config.otpFieldBorderWidth
        
        if config.shouldRequireCursor
        {
            otpField.tintColor = config.cursorColor
        }
        else
        {
            otpField.tintColor = UIColor.clear
        }
        
        // Set the default background color when text not set
        otpField.backgroundColor = config.otpFieldDefaultBackgroundColor
        
        // Finally create the fields
        otpField.initalizeUI(forFieldType: config.otpFieldDisplayType)
        
        return otpField
    }
    
    // Check if previous text fields have been entered or not before textfield can edit the selected field. This will have effect only if
    private func isPreviousFieldsEntered(forTextField textField: UITextField) -> Bool
    {
        var isTextFilled = true
        var nextOTPField: UITextField?
        
        // If intermediate editing is not allowed, then check for last filled field in forward direction.
        if !config.shouldAllowIntermediateEditing
        {
            for index in stride(from: 1, to: config.otpFieldsCount + 1, by: 1)
            {
                let tempNextOTPField = viewWithTag(index) as? UITextField
                
                if let tempNextOTPFieldText = tempNextOTPField?.text, tempNextOTPFieldText.isEmpty
                {
                    nextOTPField = tempNextOTPField
                    break
                }
            }
            
            if let nextOTPField = nextOTPField
            {
                isTextFilled = (nextOTPField == textField || (textField.tag) == (nextOTPField.tag - 1))
            }
        }
        
        return isTextFilled
    }
    
    // Helper function to get the OTP String entered
    private func reloadEnteredOTPSTring(isDeleted: Bool)
    {
        if isDeleted
        {
            _ = delegate?.hasEnteredAllOTP(hasEntered: false)
            
            // Set the default enteres state for otp entry
            for index in stride(from: 0, to: config.otpFieldsCount, by: 1)
            {
                var otpField = viewWithTag(index + 1) as? PHOTPTextField
                
                if otpField == nil
                {
                    otpField = getOTPtextField(forIndex: index)
                }
                
                let fieldBackgroundColor = (otpField?.text ?? "").isEmpty ? config.otpFieldDefaultBackgroundColor : config.otpFieldEnteredBackgroundColor
                let fieldBorderColor = (otpField?.text ?? "").isEmpty ? config.otpFieldDefaultBorderColor : config.otpFieldEnteredBorderColor
                
                if config.otpFieldDisplayType == .diamond || config.otpFieldDisplayType == .underlinedBottom
                {
                    otpField?.shapeLayer.fillColor = fieldBackgroundColor.cgColor
                    otpField?.shapeLayer.strokeColor = fieldBorderColor.cgColor
                }
                else
                {
                    otpField?.backgroundColor = fieldBackgroundColor
                    otpField?.layer.borderColor = fieldBorderColor.cgColor
                }
            }
        }
        else
        {
            var enteredOTPString = ""
            
            // Check for entered OTP
            for index in stride(from: 0, to: secureEntryData.count, by: 1)
            {
                if !secureEntryData[index].isEmpty {
                    enteredOTPString.append(secureEntryData[index])
                }
            }
            
            if enteredOTPString.count == config.otpFieldsCount
            {
                delegate?.getenteredOTP(otpString: enteredOTPString)
                
                // Check if all OTP fields have been filled or not. Based on that call the 2 delegate methods.
                let isValid = delegate?.hasEnteredAllOTP(hasEntered: (enteredOTPString.count == config.otpFieldsCount)) ?? false
               
                // Set the error state for invalid otp entry
                for index in stride(from: 0, to: config.otpFieldsCount, by: 1)
                {
                    var otpField = viewWithTag(index + 1) as? PHOTPTextField
                    
                    if otpField == nil
                    {
                        otpField = getOTPtextField(forIndex: index)
                    }
                    
                    if !isValid
                    {
                        // Set error border color if set, if not, set default border color
                        otpField?.layer.borderColor = (config.otpFieldErrorBorderColor ?? config.otpFieldEnteredBorderColor).cgColor
                        otpField?.shake()
                    }
                    else
                    {
                        otpField?.layer.borderColor = config.otpFieldEnteredBorderColor.cgColor
                    }
                }
            }
        }
    }
}

extension PHOTPView: UITextFieldDelegate
{
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool
    {
        let shouldBeginEditing = delegate?.shouldBecomeFirstResponderForOTP(otpFieldIndex: (textField.tag - 1)) ?? true
        if shouldBeginEditing
        {
            return isPreviousFieldsEntered(forTextField: textField)
        }
        
        return shouldBeginEditing
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        let replacedText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? ""
        
        // Check since only alphabet keyboard is not available in iOS
        if !replacedText.isEmpty && config.otpFieldInputType == .alphabet && replacedText.rangeOfCharacter(from: .letters) == nil {
            return false
        }
        
        if replacedText.count >= 1 {
            // If field has a text already, then replace the text and move to next field if present
            secureEntryData[textField.tag - 1] = string
            
            if config.otpFilledEntryDisplay
            {
                textField.text = " "
            }
            else
            {
                if config.otpFieldEntrySecureType
                {
                    textField.text = "*"
                }
                else
                {
                    textField.text = string
                }
            }
            
            if config.otpFieldDisplayType == .diamond || config.otpFieldDisplayType == .underlinedBottom
            {
                (textField as! PHOTPTextField).shapeLayer.fillColor = config.otpFieldEnteredBackgroundColor.cgColor
                (textField as! PHOTPTextField).shapeLayer.strokeColor = config.otpFieldEnteredBorderColor.cgColor
            }
            else
            {
                textField.backgroundColor = config.otpFieldEnteredBackgroundColor
                textField.layer.borderColor = config.otpFieldEnteredBorderColor.cgColor
            }
            
            let nextOTPField = viewWithTag(textField.tag + 1)
            
            if let nextOTPField = nextOTPField
            {
                nextOTPField.becomeFirstResponder()
            }
            else
            {
                textField.resignFirstResponder()
            }
            
            // Get the entered string
            reloadEnteredOTPSTring(isDeleted: false)
        }
        else
        {
            let currentText = textField.text ?? ""
            
            if textField.tag > 1 && currentText.isEmpty
            {
                if let prevOTPField = viewWithTag(textField.tag - 1) as? UITextField
                {
                    deleteText(in: prevOTPField)
                }
            }
            else
            {
                deleteText(in: textField)
                
                if textField.tag > 1
                {
                    if let prevOTPField = viewWithTag(textField.tag - 1) as? UITextField
                    {
                        prevOTPField.becomeFirstResponder()
                    }
                }
            }
        }
        
        return false
    }
    
    private func deleteText(in textField: UITextField)
    {
        // If deleting the text, then move to previous text field if present
        secureEntryData[textField.tag - 1] = ""
        textField.text = ""
        
        if config.otpFieldDisplayType == .diamond || config.otpFieldDisplayType == .underlinedBottom
        {
            (textField as! PHOTPTextField).shapeLayer.fillColor = config.otpFieldDefaultBackgroundColor.cgColor
            (textField as! PHOTPTextField).shapeLayer.strokeColor = config.otpFieldDefaultBorderColor.cgColor
        }
        else
        {
            textField.backgroundColor = config.otpFieldDefaultBackgroundColor
            textField.layer.borderColor = config.otpFieldDefaultBorderColor.cgColor
        }
        
        textField.becomeFirstResponder()
        
        // Get the entered string
        reloadEnteredOTPSTring(isDeleted: true)
    }
}

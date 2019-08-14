//
//  PinViewController.swift
//  PHOTPView
//
//  Created by Pankti Patel on 2019-08-13.
//  Copyright © 2019 Pankti Patel. All rights reserved.
//

import UIKit

class PinViewController: UIViewController
{

    var otpView: PHOTPView!
    var enteredOtp: String = ""
    
    var config:PinConfig! = PinConfig()

    
    var originalCodeLabel : UILabel =
    {
        let label = UILabel()
        label.text = "Code to Match"
        label.textAlignment = NSTextAlignment.center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        return label
    }()
    
    var varificationCodeTextField : UITextField =
    {
        let textfield = UITextField()
        textfield.borderStyle = .roundedRect
        textfield.placeholder = "Enter code to verify"
        textfield.text = "253674"
        textfield.textAlignment = NSTextAlignment.center
        textfield.keyboardType = .numberPad
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.clipsToBounds = true
        return textfield
    }()
    
    // MARK: - LIFE CYCLE
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setUpUI()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension PinViewController: PHOTPViewDelegate
{
    func hasEnteredAllOTP(hasEntered: Bool) -> Bool
    {
        print("Has entered all OTP? \(hasEntered)")
        return enteredOtp == varificationCodeTextField.text!
    }
    
    func shouldBecomeFirstResponderForOTP(otpFieldIndex index: Int) -> Bool
    {
        return true
    }
    
    func getenteredOTP(otpString: String) {
        enteredOtp = otpString
        print("OTPString: \(otpString)")
    }
}

extension PinViewController
{
    
    func setUpUI()
    {
        setupVarificationPINView()
        setUpVarificationCodeTextfield()
        setUpOriginalCodeLabel()
    }
    private func setupVarificationPINView()
    {
        config.otpFieldDisplayType = .square
        config.otpFieldSeparatorSpace = 10
        config.otpFieldSize = 40
        config.otpFieldsCount = 6
        config.otpFieldDefaultBorderColor = UIColor.blue
        config.otpFieldEnteredBorderColor = UIColor(red: 162/255.0, green:  179/255.0, blue:  199/255.0, alpha: 1.0)//A2B3C7
        config.otpFieldErrorBorderColor = UIColor.red
        config.otpFieldBorderWidth = 2
        config.shouldAllowIntermediateEditing = false
        
        otpView = PHOTPView(config: config)
        otpView.delegate = self

        self.view.addSubview(otpView)
        setConstraintForPinView()
        
        // Create the UI
        otpView.initializeUI()
    }
    
    private func setConstraintForPinView()
    {
        otpView.translatesAutoresizingMaskIntoConstraints = false
        otpView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        otpView.heightAnchor.constraint(equalToConstant: 60).isActive = true
        otpView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 30).isActive = true
        otpView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30).isActive = true
    }
    
    private func setUpVarificationCodeTextfield()
    {
        self.view.addSubview(varificationCodeTextField)
        
        varificationCodeTextField.bottomAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -30).isActive = true
        varificationCodeTextField.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        varificationCodeTextField.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 40).isActive = true
        varificationCodeTextField.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -40).isActive = true
        varificationCodeTextField.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    private func setUpOriginalCodeLabel()
    {
        self.view.addSubview(originalCodeLabel)
        
        originalCodeLabel.bottomAnchor.constraint(equalTo: self.varificationCodeTextField.topAnchor, constant: -30).isActive = true
        originalCodeLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        originalCodeLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 40).isActive = true
        originalCodeLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -40).isActive = true
        originalCodeLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
  
}
extension PinViewController
{
    ///Actions
    
}

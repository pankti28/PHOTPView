//
//  PHOTPTextField.swift
//  PHOTPView
//  Version 1.0
//
//  Created by Pankti Patel on 2019-08-13.
//  Copyright © 2019 Pankti Patel. All rights reserved.
//

import UIKit

class PHOTPTextField: UITextField
{
    /// Border color info for field
    var borderColor: UIColor = UIColor.black
    
    /// Border width info for field
    var borderWidth: CGFloat = 2
    
    var shapeLayer: CAShapeLayer!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func initalizeUI(forFieldType type: DisplayType)
    {
        switch type
        {
            case .circular:
                layer.cornerRadius = bounds.size.width / 2
            case .square:
                layer.cornerRadius = 0
            case .diamond:
                addDiamondMask()
            case .underlinedBottom:
                addBottomView()
        }
        
        // Basic UI setup
        if type != .diamond && type != .underlinedBottom
        {
            layer.borderColor = borderColor.cgColor
            layer.borderWidth = borderWidth
        }
        
        autocorrectionType = .no
        textAlignment = .center
    }
    
    override func deleteBackward()
    {
        super.deleteBackward()
        
        _ = delegate?.textField?(self, shouldChangeCharactersIn: NSMakeRange(0, 0), replacementString: "")
    }
    
    // Helper function to create diamond view
    fileprivate func addDiamondMask()
    {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: bounds.size.width / 2.0, y: 0))
        path.addLine(to: CGPoint(x: bounds.size.width, y: bounds.size.height / 2.0))
        path.addLine(to: CGPoint(x: bounds.size.width / 2.0, y: bounds.size.height))
        path.addLine(to: CGPoint(x: 0, y: bounds.size.height / 2.0))
        path.close()
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        
        layer.mask = maskLayer
        
        shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.lineWidth = borderWidth
        shapeLayer.fillColor = backgroundColor?.cgColor
        shapeLayer.strokeColor = borderColor.cgColor
        
        layer.addSublayer(shapeLayer)
    }
    
    // Helper function to create a underlined bottom view
    fileprivate func addBottomView()
    {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: bounds.size.height))
        path.addLine(to: CGPoint(x: bounds.size.width, y: bounds.size.height))
        path.close()
        
        shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        shapeLayer.lineWidth = borderWidth
        shapeLayer.fillColor = backgroundColor?.cgColor
        shapeLayer.strokeColor = borderColor.cgColor
        
        layer.addSublayer(shapeLayer)
    }
}
extension UIView
{
    func shake()
    {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 0.6
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        layer.add(animation, forKey: "shake")
    }
}

//
//  stylingText.swift
//  runIOT
//
//  Created by Rohit Agre on 05/02/17.
//  Copyright © 2017 Boomboxninjas.in. All rights reserved.
//

import UIKit

class stylingText: UITextField {
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
    
    let padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10);
    let accentcol = UIColor.hxc(hex: "#28201E")
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        textColor = accentcol
        layer.borderColor = accentcol.cgColor
        font = UIFont(name: "HelveticaNeue-Light", size: 17.0)
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, padding)
    }
    
    
    
    
}

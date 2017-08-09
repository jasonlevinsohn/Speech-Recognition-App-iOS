//
//  CircleButton.swift
//  Scribe-Speach-Recognition
//
//  Created by jlev on 8/9/17.
//  Copyright © 2017 L3. All rights reserved.
//

import UIKit

@IBDesignable
class CircleButton: UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = 30.0 {
        
        didSet {
            setUpView()
        }
        
    }
    
    override func prepareForInterfaceBuilder() {
        setUpView()
    }
    
    func setUpView() {
        layer.cornerRadius = cornerRadius
    }
}

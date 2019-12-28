//
//  UIKitExtension.swift
//  Shopping
//
//  Created by apple on 2019/12/27.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit

extension UILabel {
    
    convenience init(text: String, textColor: UIColor, font: UIFont, bkColor: UIColor = .white) {
        self.init()
        self.text = text
        self.textColor = textColor
        self.font = font
        self.backgroundColor = bkColor
    }

}

extension UIButton {
    convenience init(text: String, textColor: UIColor, font: UIFont, bkColor: UIColor = .white) {
        self.init()
        self.backgroundColor = bkColor
        self.titleLabel?.font = font
        self.setTitle(text, for: .normal)
        self.setTitleColor(textColor, for: .normal)
    }
}



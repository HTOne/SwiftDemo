//
//  BaseCollectionViewCell.swift
//  Shopping
//
//  Created by apple on 2019/11/1.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit
import Reusable


class BaseCollectionViewCell: UICollectionViewCell, Reusable {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = UIColor.contentColor
        configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func configUI() {}
}

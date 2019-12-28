//
//  HTBaseCollectionReusableView.swift
//  Own
//
//  Created by apple on 2019/10/10.
//  Copyright © 2019 万海堂. All rights reserved.
//

import UIKit
import Reusable

class HTBaseCollectionReusableView: UICollectionReusableView, Reusable {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.contentColor
        configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func configUI() {}
}

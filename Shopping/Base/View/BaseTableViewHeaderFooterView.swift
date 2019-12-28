//
//  HTBaseTableViewHeaderFooterView.swift
//  Own
//
//  Created by apple on 2019/10/10.
//  Copyright © 2019 万海堂. All rights reserved.
//

import UIKit


class HTBaseTableViewHeaderFooterView: UITableViewHeaderFooterView {

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor.contentColor
        configUI()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func configUI() {}
}

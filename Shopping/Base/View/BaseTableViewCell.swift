//
//  BaseTableViewCell.swift
//  Shopping
//
//  Created by apple on 2019/11/1.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit
import Reusable

class BaseTableViewCell: UITableViewCell, Reusable {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor.contentColor
        selectionStyle = .none
        configUI();
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func configUI() {}
    

}

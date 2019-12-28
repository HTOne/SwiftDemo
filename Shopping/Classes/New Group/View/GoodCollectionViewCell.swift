//
//  GoodCollectionViewCell.swift
//  Shopping
//
//  Created by apple on 2019/12/18.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit
import Kingfisher

class GoodCollectionViewCell: BaseCollectionViewCell {
    
    
    
    private lazy var iconView: UIImageView = {
        let iw = UIImageView()
        iw.contentMode = .scaleAspectFill
        return iw
    }()
    
    private lazy var titleL: UILabel = {
        return UILabel(text: "", textColor: .black, font: .systemFont(ofSize: 14))
    }()
    
    private lazy var priceL: UILabel = {
        return UILabel(text: "", textColor: .red, font: .systemFont(ofSize: 14))
    }()

    
    override func configUI() {
        layer.cornerRadius = 5
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGray.withAlphaComponent(0.5).cgColor
        layer.masksToBounds = true
        
        contentView.addSubview(iconView)
        iconView.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(self.iconView.snp_width)
        }
        
        contentView.addSubview(titleL)
        titleL.snp.makeConstraints {
            $0.top.equalTo(iconView.snp_bottom).offset(5)
            $0.left.equalToSuperview().offset((5))
        }
        contentView.addSubview(priceL)
        priceL.snp.makeConstraints {
           $0.top.equalTo(titleL.snp_bottom).offset(5)
           $0.left.equalToSuperview().offset((5))
        }

    }
    
    var model: GoodsModel? {
        didSet {
            guard let model = model else { return }
            iconView.kf.setImage(urlString: model.pic_cover_mid)
            titleL.text = model.goods_name
            priceL.text = model.price
        }
    }
}

//
//  AssortModel.swift
//  Shopping
//
//  Created by apple on 2019/11/21.
//  Copyright © 2019 apple. All rights reserved.
//

import HandyJSON


// home

struct BannerModel: HandyJSON {
    var adv_title: String?
    var adv_url: String?
    var adv_image: String?
    var adv_id: String?
}
struct Banners: HandyJSON {
    var adv_list: [BannerModel]?
}

struct GoodsModel: HandyJSON {
    var goods_id: String?
    var goods_name: String?
    var price: String?
    var promotion_price: String?
    var pic_cover_mid: String?
    var discount: String?
}


struct HomeData: HandyJSON {
    var free: [GoodsModel]?
    var discount: [GoodsModel]?
    var recommend: [GoodsModel]?
}

struct AssortModel: HandyJSON {
    var category_id: String?
    var category_name: String?
}

struct AssortList: HandyJSON {
    var list: [AssortModel]?
}

struct ResponseData<T: HandyJSON>: HandyJSON {
    var code: Int = 0
    var msg: String?
    var data: T?
}

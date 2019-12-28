//
//  Refresh.swift
//  Shopping
//
//  Created by apple on 2019/12/18.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit
import MJRefresh

extension UIScrollView {
    var head: MJRefreshHeader {
        get { return mj_header }
        set { mj_header = newValue }
    }
    
    var foot: MJRefreshFooter {
        get { return mj_footer }
        set { mj_footer = newValue }
    }
}


class RefreshHeader: MJRefreshGifHeader {
    override func prepare() {
        super.prepare()
        setImages([UIImage(named: "refresh_normal")!], for: .idle)
        setImages([UIImage(named: "refresh_will_refresh")!], for: .pulling)
        setImages([UIImage(named: "refresh_loading_1")!,
                   UIImage(named: "refresh_loading_2")!,
                   UIImage(named: "refresh_loading_3")!], for: .refreshing)
        
        lastUpdatedTimeLabel.isHidden = true
        stateLabel.isHidden = true
    }
}

class RefreshAutoHeader: MJRefreshHeader {}

class RefreshFooter: MJRefreshBackNormalFooter {}

class RefreshAutoFooter: MJRefreshAutoFooter {}



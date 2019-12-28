//
//  TabBarController.swift
//  Own
//
//  Created by 万海堂 on 2019/7/22.
//  Copyright © 2019 万海堂. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        tabBar.isTranslucent = false
        tabBar.backgroundImage = UIColor.white.image()
    
        setupAllChileViewController()
        
    }
    
    func setupAllChileViewController() {
        
        let home = HomeViewController()
        addChildController(home, title: "首页", image: UIImage(named: "tabbar_home_normal"), selectedImage: UIImage(named: "tabbar_home_selected"))
        
        let assort = AssortViewController()
        addChildController(assort, title: "分类", image: UIImage(named: "tabbar_category_normal"), selectedImage: UIImage(named: "tabbar_category_selected"))
        
        let shoppCart = ShoppCartViewController()
        addChildController(shoppCart, title: "购物车", image: UIImage(named: "tabbar_shoppcart_normal"), selectedImage: UIImage(named: "tabbar_shoppcart_selected"))
        
        let brocast = BrocastViewController()
        addChildController(brocast, title: "直播", image: UIImage(named: "tabbar_live_broadcast_normal"), selectedImage: UIImage(named: "tabbar_live_broadcast_selected"))
        
        let mine = MineViewController()
        addChildController(mine, title: "我的", image: UIImage(named: "tabbar_mine_normal"), selectedImage: UIImage(named: "tabbar_mine_selected"))
    }
    
    
    func addChildController(_ childController: UIViewController, title: String, image: UIImage?, selectedImage: UIImage?) {
        
        childController.title = title
        childController.tabBarItem = UITabBarItem(title: title, image: image?.withRenderingMode(.alwaysOriginal), selectedImage: selectedImage?.withRenderingMode(.alwaysOriginal))
        
    childController.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.hex(hexString: "CCCCCC"), NSAttributedString.Key.font : UIFont.systemFont(ofSize: 11)], for: .normal)
    
    childController.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.hex(hexString: "FF5960"), NSAttributedString.Key.font : UIFont.systemFont(ofSize: 11)], for: .selected)

        addChild(BaseNavigationController(rootViewController: childController))
    }

}


extension TabBarController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        guard let select = selectedViewController else { return .lightContent }
        return select.preferredStatusBarStyle
    }
}

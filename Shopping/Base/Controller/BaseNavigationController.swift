//
//  BaseNavigationController.swift
//  Shopping
//
//  Created by apple on 2019/11/1.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.barStyle(.white)
            
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font : UIFont.systemFont(ofSize: 18)]
        
        let textAttrs = [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font : UIFont.systemFont(ofSize: 14)]
        let barItem = UIBarButtonItem.appearance()
        barItem.setTitleTextAttributes(textAttrs, for: .normal)
        barItem.setTitleTextAttributes(textAttrs, for: .selected)
        barItem.setTitleTextAttributes(textAttrs, for: .highlighted)
        
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
          if viewControllers.count > 0 {
              viewController.hidesBottomBarWhenPushed = true
          }
          super .pushViewController(viewController, animated: animated)
      }


}

extension BaseNavigationController {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        guard let topVc = topViewController else {
            return .lightContent
        }
        return topVc.preferredStatusBarStyle
    }
}


enum NavigationBarStyle {
    case theme
    case clear
    case white
}

extension UINavigationController {

    func barStyle(_ style: NavigationBarStyle) {
        switch style {
        case .theme:
            navigationBar.barStyle = .black
            navigationBar.setBackgroundImage(UIImage(named: ""), for: .default)
        case .clear:
            navigationBar.barStyle = .black
            navigationBar.setBackgroundImage(UIImage(), for: .default)
            navigationBar.shadowImage = UIImage()
        case .white:
            navigationBar.barStyle = .default
            navigationBar.setBackgroundImage(UIColor.theme.image(), for: .default)
            navigationBar.shadowImage = nil
        }
    }
}

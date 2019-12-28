//
//  Global.swift
//  Shopping
//
//  Created by apple on 2019/11/1.
//  Copyright © 2019 apple. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher
import SnapKit

extension UIColor {
    class var background: UIColor {
        return UIColor.hex(hexString: "F5F5F5")
    }
    class var theme: UIColor {
        return UIColor.hex(hexString: "EA324D")
    }
    class var contentColor: UIColor {
        return UIColor.hex(hexString: "ffffff")
    }
    
}

extension String {
    var absoluteStr: String {
        if self.contains("http:") {
            return self
        } else {
            return "http://gb.coinpaybbs.com/api.php\(self)"
        }
    }
}

let screenWidth = UIScreen.main.bounds.width
let screenHeight = UIScreen.main.bounds.height

var topVc: UIViewController? {
    var resultVc: UIViewController?
    resultVc = _topVc(UIApplication.shared.keyWindow?.rootViewController)
    while resultVc?.presentedViewController != nil {
        resultVc = _topVc(resultVc?.presentedViewController)
    }
    return resultVc
}



var isIphoneX: Bool {
    return UI_USER_INTERFACE_IDIOM() == .phone
        && (max(UIScreen.main.bounds.height, UIScreen.main.bounds.height) == 812 || max(UIScreen.main.bounds.height, UIScreen.main.bounds.height) == 896)
}




private func _topVc(_ vc: UIViewController?) -> UIViewController? {
    if vc is UINavigationController {
        return _topVc((vc as? UINavigationController)?.topViewController)
    } else if vc is UITabBarController {
        return _topVc((vc as? UITabBarController)?.selectedViewController)
    } else {
        return vc
    }
}

//MARK: Kingfisher
extension Kingfisher where Base: ImageView {
    @discardableResult
    public func setImage(urlString: String?, placeholder: Placeholder? = UIImage(named: "normal_placeholder_h")) -> RetrieveImageTask {
        return setImage(with: URL(string: urlString ?? ""),
                        placeholder: placeholder,
                        options:[.transition(.fade(0.5))])
    }
}

extension Kingfisher where Base: UIButton {
    @discardableResult
    public func setImage(urlString: String?, for state: UIControl.State, placeholder: UIImage? = UIImage(named: "normal_placeholder_h")) -> RetrieveImageTask {
        return setImage(with: URL(string: urlString ?? ""),
                        for: state,
                        placeholder: placeholder,
                        options: [.transition(.fade(0.5))])
        
    }
}
//MARK: SnapKit
extension ConstraintView {
    
    var usnp: ConstraintBasicAttributesDSL {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.snp
        } else {
            return self.snp
        }
    }
}

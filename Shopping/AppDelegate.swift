//
//  AppDelegate.swift
//  Shopping
//
//  Created by apple on 2019/11/1.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit
import Alamofire
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    lazy var reachability: NetworkReachabilityManager? = {
          return NetworkReachabilityManager(host: "http://app.u17.com")
      }()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        configBase()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        window?.rootViewController = TabBarController()//LoginViewController()
        window?.makeKeyAndVisible()
        return true
    }

    
    func configBase() {
        //MARK: 键盘处理
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        
        //MARK: 性别缓存

        //MARK: 网络监控
        reachability?.listener = { status in
            switch status {
            case .reachable(.wwan):
//                UNoticeBar(config: UNoticeBarConfig(title: "主人,检测到您正在使用移动数据")).show(duration: 2)
                break
            default: break
            }
        }
        reachability?.startListening()
    }

}


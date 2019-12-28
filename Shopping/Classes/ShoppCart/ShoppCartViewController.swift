//
//  ShoppCartViewController.swift
//  Shopping
//
//  Created by apple on 2019/11/11.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit

class ShoppCartViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        mallProvider.request(.assort, model: AssortList.self) { (returnData) in
            print(returnData!)
        }
        
        let stack = UIStackView(frame: CGRect(x: 0, y: 100, width: view.bounds.size.width, height: 100))
        stack.backgroundColor = UIColor.orange
        stack.axis = .horizontal
        stack.distribution = .equalCentering
        stack.spacing = 10
        stack.alignment = .center
        
        let c = UIView(frame: stack.bounds)
        c.backgroundColor = UIColor.yellow
        stack .addSubview(c);
        
        
        
        for _ in (0..<4)  {
            let label = UILabel()
            label.text = "ceshi122"
            label.backgroundColor = .green
            label.textAlignment = .center
            stack.addArrangedSubview(label)

        }

        view.addSubview(stack)
        
        
        
//        mallProvider.request(.login("13530014523", "654321")) { result in
//            do {
//                let response = try result.get()
//                let jsonString = try? response.mapString()
//                print(jsonString as Any)
//            } catch {
//                let printableError = error as CustomStringConvertible
//                print(printableError.description)
//            }
//        }
    }
    

}

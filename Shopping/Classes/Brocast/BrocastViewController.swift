//
//  BrocastViewController.swift
//  Shopping
//
//  Created by apple on 2019/11/11.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

typealias Byte = Int8


/// 关联值（Associated Values）
enum Score {
    case points(Int)
    case grade(Character)
}
enum Date {
    case digit(year: Int, month: Int, day: Int)
    case string(String)
}


/// 递归枚举（Recursive Enumeration）
indirect enum ArithExpr {
    case number(Int)
    case sum(ArithExpr, ArithExpr)
    case difference(ArithExpr, ArithExpr)
}

// 嵌套类型

protocol Stackable {
     associatedtype Element // 关联类型
     mutating func push(_ element: Element)
     mutating func pop() -> Element
     func top() -> Element
     func size() -> Int
 }

class Stack<E>: Stackable {
    typealias Element = E
    var elements = [E]()
    func push(_ element: E) {
        elements.append(element)
    }
    
    func pop() -> E {
        elements.removeLast()
    }
    
    func top() -> E {
        elements.last!
    }
    
    func size() -> Int {
        elements.count
    }

}

//class StringStack: Stackable {
//    typealias Element = String
//
//    var elements = [String]()
//}



class BrocastViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let b = UIButton(text: "btn", textColor: .red, font: .systemFont(ofSize: 18), bkColor: .clear)
//        b.frame = CGRect(origin: view.center, size: CGSize(width: 60, height: 30))
        view.addSubview(b)
        b.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        let observable = Observable<Int>.timer(.seconds(2), period: .seconds(1), scheduler: MainScheduler.instance)
        let binder = Binder<Bool>(b) { button, value in
            button.isHidden = value
        }

        let _ = observable.takeUntil(self.rx.deallocated).map { $0 % 2 == 0 }.bind(to: binder)
        
        let _ = b.rx.controlEvent(.touchUpInside)
            .takeUntil(self.rx.deallocated)
            .subscribe(onNext: { e in
                print(e)
        })
        

    }
    
    func testProtocol() {
 
    }
    //@discardableResult
    func singl() {
        class FileManager {
//            public static let shard = FileManager()
            public static let shard = {
                return FileManager()
            }()
            private init() {}
        }
        
    
    }
    func testProper() {
        // 存储属性 计算属性 延迟存储属性
    
        class Car {
            lazy var s = String()

            
        }
    }
    
    func testClosure() {
        // 闭包表达式 （closure expression）
        //可以通过func定义一个函数，也可以通过闭包表达式定义一个函数
        let fn =  {
            (v1: Int, v2: Int) -> Int in
            return v1 + v2
        }
        print(fn(10, 20))
        
        //简写
        func exec(v1: Int, v2: Int, fn: (Int, Int) -> Int) {
            print(fn(v1, v2))
        }
        
        exec(v1: 10, v2: 20) { (v1, v2) -> Int in
            return v1 + v2
        }
        exec(v1: 10, v2: 20, fn: {
            v1, v2 in return v1 + v2
        })
        
        exec(v1: 10, v2: 20, fn: {
            v1, v2 in v1 + v2
        })
        
        exec(v1: 10, v2: 20, fn: { $0 + $1 })
        exec(v1: 10, v2: 20, fn: +)
        
        // 尾随闭包
        exec(v1: 10, v2: 20) {
            $0 + $1
        }
        
        // 闭包（Closure）
        // 一个函数和它所捕获的变量、常量环境组合起来
        // - 一般之定义在函数内部的函数
        // - 一般它捕获的是外层函数的局部变量、常量
        typealias Fn = (Int) -> Int
        func getFn() -> Fn {
            var num = 0
            func plus(_ i: Int) -> Int {
                num += i
                return num
            }
            return plus
        }
        
        // 自动闭包 （@autoclosure）这个值会被推迟执行
        @discardableResult
        func getFirstPositive(_ v1: Int, _ v2: () -> Int) -> Int? {
            return v1 > 0 ? v1 : v2()
        }
        @discardableResult
        func getFirstPositive2(_ v1: Int, _ v2: @autoclosure () -> Int) -> Int? {
            return v1 > 0 ? v1 : v2()
        }
        getFirstPositive(-4) { 20 }
        getFirstPositive2(-4, 20)
        
    }
    
    func testOptions() {
        let a: Int? = nil
        let b: Int? = 2
        if let c = a ?? b {
            print(c)
            //a != nil || b != nil
        }
        if let c = a, let d = b {
            print(c, d)
            //a != nil && b != nil
        }
    }
    
    @discardableResult
    func calculate(_ expr: ArithExpr) -> Int {
        switch expr {
        case let .number(value):
            return value
        case let .sum(left, right):
            return calculate(left) + calculate(right)
        case let .difference(left, right):
            return calculate(left) - calculate(right)
        }
    }
    func testEnum() {
        var s = Score.points(96)
        s = .grade("A")
        
        let five = ArithExpr.number(5)
        let four = ArithExpr.number(4)
        let sum = ArithExpr.sum(five, four)
        let difference = ArithExpr.difference(sum, five)
        calculate(difference)
        
    }
    
    func area() {
        let range: ClosedRange<Int> = 0...3
        for i in range {
           print(i)
        }
    }



}

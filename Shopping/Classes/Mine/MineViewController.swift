//
//  MineViewController.swift
//  Shopping
//
//  Created by apple on 2019/11/11.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift


struct Person {
    var name: String
    var age: Int
    
}

class MineViewController: BaseViewController {
    
    lazy var tb: UITableView = {
        let t = UITableView(frame: self.view.bounds, style: .plain)
        
        return t
    }()
    
    let persons = Observable.just([
        Person(name: "Jack", age: 20),
        Person(name: "Rose", age: 23),
        Person(name: "Ryan", age: 24),
        Person(name: "Kate", age: 25)
    ])
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tb)
        tb.register(cellType: TitleCell.self)
        tb.rowHeight = 200
        
       let _ = persons.takeUntil(self.rx.deallocated).bind(to: tb.rx.items(cellIdentifier: "TitleCell")) {
            row, person, cell in
            cell.textLabel?.text = person.name
        }
        
        let _ = tb.rx.itemSelected.takeUntil(self.rx.deallocated).subscribe(onNext: { indexpath in
            print(indexpath)
        })
        
    }
    
    
    
    


}

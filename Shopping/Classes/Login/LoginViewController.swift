//
//  LoginViewController.swift
//  Shopping
//
//  Created by apple on 2019/12/26.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

private let minimalUsernameLength = 5
private let minimalPasswordLength = 5

enum DataError: Error {
    case cantParseJSON
}

class SimpleValidationViewModel {
    let usernameValid: Observable<Bool>
    let passwordValid: Observable<Bool>
    let everythingValid: Observable<Bool>

    init(username: Observable<String>, password: Observable<String>) {
        usernameValid = username.map { $0.count >= minimalUsernameLength }.share(replay: 1)
        passwordValid = password.map {$0.count >= minimalPasswordLength }.share(replay: 1)

        everythingValid = Observable.combineLatest(usernameValid, passwordValid) {
            $0 && $1
        }.share(replay: 1)
    }
}

class LoginViewController: BaseViewController {
    
    @IBOutlet weak var doSomethingB: UIButton!
    
    @IBOutlet weak var userNameTextF: UITextField!
    @IBOutlet weak var userWarmL: UILabel!
    @IBOutlet weak var passwordTextF: UITextField!
    @IBOutlet weak var psswordWarnL: UILabel!
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        test()
        singleTest("ReactiveX/RxSwift")
            .subscribe(onSuccess: { json in
                print("JSON: ", json)
            }, onError: { error in
                print("Error: ", error)
            })
            .disposed(by: disposeBag)

        userWarmL.text = "Username has to be at least \(minimalUsernameLength) characters"
        psswordWarnL.text = "Password has to be at least \(minimalPasswordLength) characters"
        let userValid = userNameTextF.rx.text.orEmpty
            .map{ $0.count >= minimalUsernameLength }.share(replay: 1)
        let pwdValid = passwordTextF.rx.text.orEmpty
            .map{ $0.count >= minimalPasswordLength }.share(replay: 1)
        let everythingValid = Observable.combineLatest(userValid, pwdValid){ $0 && $1}
            .share(replay: 1)
        
        userValid
            .bind(to:passwordTextF.rx.isEnabled)
            .disposed(by: disposeBag)
        
        userValid
            .bind(to: userWarmL.rx.isHidden)
            .disposed(by: disposeBag)
        
        pwdValid
            .bind(to: psswordWarnL.rx.isHidden)
            .disposed(by: disposeBag)

        everythingValid
            .bind(to: doSomethingB.rx.isEnabled)
            .disposed(by: disposeBag)

        doSomethingB.rx.tap.subscribe(onNext: { [weak self] _ in self?.showAlert() })
            .disposed(by: disposeBag)
        
    }
    
    func showAlert() {
        let alertView = UIAlertView(
            title: "RxExample",
            message: "This is wonderful",
            delegate: nil,
            cancelButtonTitle: "OK"
        )
        alertView.show()
    }
    
    func test() {
        let numbers: Observable<Int> = Observable.create { observer -> Disposable in
            observer.onNext(0)
            observer.onNext(1)
            observer.onNext(2)
            observer.onNext(3)
            observer.onNext(4)
            observer.onNext(5)
            observer.onNext(6)
            observer.onCompleted()
            return Disposables.create()
        }
        
        numbers.subscribe(onNext: { value in
            print(value)
        }, onError: { error in
            print(error)
        }, onCompleted: {
            print("onCompleted")
        }) {
           print("disposeBag")
        }.disposed(by: disposeBag)
    }
    
    func singleTest(_ repo: String) -> Single<[String: Any]> {
        return Single.create { single in
            let url = URL(string: "https://api.github.com/repos/\(repo)")!
            let task = URLSession.shared.dataTask(with: url) { (data, _, error) in
                if let err = error {
                    single(.error(err))
                    return
                }
                
                guard let data = data,
                    let json = try? JSONSerialization.jsonObject(with: data, options: .mutableLeaves),
                    let result = json as? [String: Any] else {
                        single(.error(DataError.cantParseJSON))
                        return
                }
                single(.success(result))
            }
            task.resume()
            
            return Disposables.create { task.cancel() }
        }
    }
    
}

//
//  ValidationViewController.swift
//  RxSwiftSample
//
//  Created by satoutakeshi on 2016/06/29.
//  Copyright © 2016年 satoutakeshi. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
class ValidationViewController: UIViewController {


    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,20}"
        
        let emailVaild =  emailTextField.rx_text
            .map(){ text in
                
                return NSPredicate(format:"SELF MATCHES %@", emailRegEx).evaluateWithObject(text)
                
            }.shareReplay(1)
        
        let passwordValid = passwordTextField.rx_text
            .map { $0.characters.count >= 6 }
            .shareReplay(1)
        
        let everythingValid = Observable.combineLatest(emailVaild, passwordValid) { $0 && $1 }
            .shareReplay(1)
        
        everythingValid.bindTo(registerButton.rx_enabled)
        .addDisposableTo(disposeBag)
        
        registerButton.rx_tap.subscribeNext {
            [weak self] in
            self?.showAlert()
        }.addDisposableTo(disposeBag)
    }
    
    func showAlert () {
        let alertViewCon  = UIAlertController.init(title: "登録完了", message: "", preferredStyle: .Alert)
        
        let actinon = UIAlertAction.init(title: "OK", style: .Default, handler: nil)
        
        alertViewCon.addAction(actinon)
        
        alertViewCon.view.layoutIfNeeded()

        self.presentViewController(alertViewCon, animated: true, completion: nil)
        
    }

}

//
//  ButtonTapViewController.swift
//  RxSwiftSample
//
//  Created by satoutakeshi on 2016/06/29.
//  Copyright © 2016年 satoutakeshi. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
class ButtonTapViewController: UIViewController {

    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var tapButton: UIButton!
    let disposeBag = DisposeBag()
    
    let count = Variable<Int>(0)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        count.asObservable().map {
            String($0)
        }.bindTo(countLabel.rx_text)
        .addDisposableTo(disposeBag)
        
        tapButton.rx_tap.subscribeNext { [weak self] in
            self?.count.value += 1
        }.addDisposableTo(disposeBag)
    }


}

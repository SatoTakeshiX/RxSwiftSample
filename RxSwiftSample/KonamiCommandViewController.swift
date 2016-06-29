//
//  KonamiCommandViewController.swift
//  RxSwiftSample
//
//  Created by satoutakeshi on 2016/06/28.
//  Copyright © 2016年 satoutakeshi. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
class KonamiCommandViewController: UIViewController {

    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var rightKeyButton: UIButton!
    @IBOutlet weak var downKeyButton: UIButton!
    @IBOutlet weak var leftKeyButton: UIButton!
    @IBOutlet weak var upKeyButton: UIButton!
    @IBOutlet weak var aKeyButton: UIButton!
    @IBOutlet weak var bKeyButton: UIButton!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let viewModel = KonamiCommandViewModel()
        
        let commands: [Observable<KeyAction>] = [
            
            rightKeyButton.rx_tap.map { _ in .AddKey("→") },
            downKeyButton.rx_tap.map { _ in .AddKey("↓") },
            leftKeyButton.rx_tap.map { _ in .AddKey("←") },
            upKeyButton.rx_tap.map { _ in .AddKey("↑") },
            aKeyButton.rx_tap.map { _ in .AddKey("a") } ,
            bKeyButton.rx_tap.map { _ in .AddKey("b") }
        ]
        
        commands
            .toObservable()
            .merge()
            .scan(KeyState.CLEAR_STATE) { KeyState, KeyAction in
                //scan ->最初は初期状態から初めて、ActionによってkeyStateインスタンスを生成し直す
                return KeyState.transformState(KeyAction)
                
            }.map {
                $0.currentCommand
            }
            .bindTo(viewModel.commands)
        .addDisposableTo(disposeBag)
        
        viewModel.commands
            .asObservable()
            .debug()
            .subscribeNext {
            [weak self] text in
            
            if text.characters.count < 10 {
                self?.resultLabel.text  = "世界を救え"
            }
            else if text == "↑↑↓↓←→←→ba" {
                self?.resultLabel.text = "世界は救われた"
            } else {
                self?.resultLabel.text = "＼(^o^)／"
                }
        }.addDisposableTo(disposeBag)
    }
}

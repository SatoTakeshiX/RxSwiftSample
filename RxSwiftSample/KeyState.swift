//
//  KeyState.swift
//  RxSwiftSample
//
//  Created by satoutakeshi on 2016/06/29.
//  Copyright © 2016年 satoutakeshi. All rights reserved.
//

import Foundation

struct KeyState {
    static let CLEAR_STATE = KeyState(action: .Clear, currentCommand: "")
    let action: KeyAction
    let currentCommand: String!

}

extension KeyState {
    //引数(Action)によって、TenkeyStateインスタンスを返すメソッド
    func transformState(action: KeyAction) -> KeyState {
        switch action {
        case .Clear:
            return KeyState.CLEAR_STATE
        case .AddKey(let character):
            return addNumber(character)
        }
    }
    
    //コマンドを追加する
    func addNumber(char: Character) -> KeyState {
        let tempCommand = currentCommand == nil ? String(char) : currentCommand + String(char)
        let newCurrentCommand = tempCommand.characters.count <= 10 ? tempCommand : String(char)
        return KeyState(action: action, currentCommand: newCurrentCommand)
    }
}
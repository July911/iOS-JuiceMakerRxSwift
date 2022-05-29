//
//  Juice.swift
//  iOS-JuiceMakerRxSwift
//
//  Created by 조영민, 심재훈 on 2022/05/30.
//

import Foundation

enum Juice {
    
    case strawberryBananaJuice
    case mangoKiwiJuice
    case strawberryJuice
    case bananaJuice
    case pineappleJuice
    case kiwiJuice
    case mangoJuice
    
    var recipe: Dictionary<Fruit, Int> {
        switch self {
        case .strawberryJuice:
            return [.strawberry: 16]
        case .bananaJuice:
            return [.banana: 2]
        case .kiwiJuice:
            return [.kiwi: 3]
        case .pineappleJuice:
            return [.pineapple: 2]
        case .strawberryBananaJuice:
            return [.strawberry: 10, .banana: 1]
        case .mangoJuice:
            return [.mango: 3]
        case .mangoKiwiJuice:
            return [.mango: 2, .kiwi: 1]
        }
    }
}

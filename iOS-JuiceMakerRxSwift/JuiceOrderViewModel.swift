//
//  JuiceOrderViewModel.swift
//  iOS-JuiceMakerRxSwift
//
//  Created by 조영민 on 2022/05/30.
//

import Foundation
import RxSwift
import RxCocoa

final class JuiceOrderViewModel {
    
    private let juiceMaker: JuiceMaker
    
    init(juiceMaker: JuiceMaker) {
        self.juiceMaker = juiceMaker
    }
    
    struct Input {
        let viewWillAppear: Observable<Void>
        let strawberryOrderButtonDidTapped: Driver<Void>
        let kiwiOrderButtonDidTapped: Driver<Void>
        let mangoOrderButtonDidTapped: Driver<Void>
        let pineappleOrderButtonDidTapped: Driver<Void>
        let bananaOrderButtonDidTapped: Driver<Void>
        let mangoKiwiOrderButtonDidTapped: Driver<Void>
        let strawberryBananaOrderButtonDidTapped: Driver<Void>
    }
    
    struct Output {
        let strawberryValue: Driver<String>
        let kiwiValue: Driver<String>
        let mangoValue: Driver<String>
        let pineappleValue: Driver<String>
        let bananaValue: Driver<String>
        let orderResult: Driver<String>
    }
    
    func transform(input: Input) -> Output {
        // 현업
        // 쥬스의 재고 감소를 요청했는데
        // 재료가 없는거를 에러로 봐야될지
        // 404에러 -> 끊김
        // 어떤 요청에대한 응답

        let starwberryOrderResult = input.strawberryOrderButtonDidTapped
            .flatMap { self.juiceMaker.makeJuice(ingredient: .strawberryJuice).map { String($0.name) }.asDriver(onErrorJustReturn: "재고없음") }

        let kiwiOrderResult = input.kiwiOrderButtonDidTapped
            .flatMap { self.juiceMaker.makeJuice(ingredient: .kiwiJuice).map { String($0.name) }.asDriver(onErrorJustReturn: "재고없음") }

        let mangoOrderResult = input.mangoOrderButtonDidTapped
            .flatMap { self.juiceMaker.makeJuice(ingredient: .mangoJuice).map { String($0.name) }.asDriver(onErrorJustReturn: "재고없음") }

        let pineappleOrderResult = input.pineappleOrderButtonDidTapped
            .flatMap { self.juiceMaker.makeJuice(ingredient: .pineappleJuice).map { String($0.name) }.asDriver(onErrorJustReturn: "재고없음") }

        let bananaOrderResult = input.bananaOrderButtonDidTapped
            .flatMap { self.juiceMaker.makeJuice(ingredient: .bananaJuice).map { String($0.name) }.asDriver(onErrorJustReturn: "재고없음") }

        let mangoKiwiOrderResult = input.mangoKiwiOrderButtonDidTapped
            .flatMap { self.juiceMaker.makeJuice(ingredient: .mangoKiwiJuice).map { String($0.name) }.asDriver(onErrorJustReturn: "재고없음") }

        let strawberryBananaOrderResult = input.strawberryBananaOrderButtonDidTapped
            .flatMap { self.juiceMaker.makeJuice(ingredient: .strawberryBananaJuice).map { String($0.name) }.asDriver(onErrorJustReturn: "재고없음") }

        let orderResults = Driver.merge(
            starwberryOrderResult,
            kiwiOrderResult,
            mangoOrderResult,
            pineappleOrderResult,
            bananaOrderResult,
            mangoKiwiOrderResult,
            strawberryBananaOrderResult
        )
        
        let allStock = input.viewWillAppear
            .flatMap { self.juiceMaker.fetchAll() }
            .asDriver(onErrorJustReturn: [:])

        let strawberryValue = allStock
            .compactMap { $0[.strawberry] }
            .map(String.init)

        let kiwiValue = allStock
            .compactMap { $0[.kiwi] }
            .map(String.init)

        let mangoValue = allStock
            .compactMap { $0[.mango] }
            .map(String.init)

        let pineappleValue = allStock
            .compactMap { $0[.pineapple] }
            .map(String.init)

        let bananaValue = allStock
            .compactMap { $0[.banana] }
            .map(String.init)

        return Output(
            strawberryValue: strawberryValue,
            kiwiValue: kiwiValue,
            mangoValue: mangoValue,
            pineappleValue: pineappleValue,
            bananaValue: bananaValue,
            orderResult: orderResults
        )
    }
}

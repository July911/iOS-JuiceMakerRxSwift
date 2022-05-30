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
            .debug()

        let kiwiOrderResult = input.strawberryOrderButtonDidTapped
            .flatMap { self.juiceMaker.makeJuice(ingredient: .kiwiJuice).asDriverOnErrorJustComplete() }

        let mangoOrderResult = input.strawberryOrderButtonDidTapped
            .flatMap { self.juiceMaker.makeJuice(ingredient: .mangoJuice).asDriverOnErrorJustComplete() }

        let pineappleOrderResult = input.strawberryOrderButtonDidTapped
            .flatMap { self.juiceMaker.makeJuice(ingredient: .pineappleJuice).asDriverOnErrorJustComplete() }

        let bananaOrderResult = input.strawberryOrderButtonDidTapped
            .flatMap { self.juiceMaker.makeJuice(ingredient: .bananaJuice).asDriverOnErrorJustComplete() }

        let mangoKiwiOrderResult = input.mangoKiwiOrderButtonDidTapped
            .flatMap { self.juiceMaker.makeJuice(ingredient: .mangoKiwiJuice).asDriverOnErrorJustComplete() }

        let strawberryBananaOrderResult = input.strawberryBananaOrderButtonDidTapped
            .flatMap { self.juiceMaker.makeJuice(ingredient: .strawberryBananaJuice).asDriverOnErrorJustComplete() }

        let orderResults = Driver.merge(
            starwberryOrderResult,
            kiwiOrderResult,
            mangoOrderResult,
            pineappleOrderResult,
            bananaOrderResult,
            mangoKiwiOrderResult,
            strawberryBananaOrderResult
        ).map {
            $0.name
        }.asDriver(onErrorJustReturn: "재고가 부족합니다.")
            .debug()

        let allStock = input.viewWillAppear
            .flatMap { self.juiceMaker.fetchAll() }
            .asDriver(onErrorJustReturn: [:])

        let strawberryValue = allStock
            .map { $0[.strawberry, default: 0] }
            .map(String.init)

        let kiwiValue = allStock
            .map { $0[.kiwi, default: 0] }
            .map(String.init)

        let mangoValue = allStock
            .map { $0[.mango, default: 0] }
            .map(String.init)

        let pineappleValue = allStock
            .map { $0[.pineapple, default: 0] }
            .map(String.init)

        let bananaValue = allStock
            .map { $0[.banana, default: 0] }
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

extension ObservableType {

    func catchErrorJustComplete() -> Observable<Element> {
        return catchError { _ in
            return Observable.empty()
        }
    }

    func asDriverOnErrorJustComplete() -> Driver<Element> {
        return asDriver { error in
            return Driver.empty()
        }
    }

    func mapToVoid() -> Observable<Void> {
        return map { _ in }
    }
}

//
//  EditStockViewModel.swift
//  iOS-JuiceMakerRxSwift
//
//  Created by 조영민 on 2022/05/30.
//

import Foundation
import RxSwift
import RxCocoa

final class EditStockViewModel {
    
    private let juiceMaker: JuiceMaker
    
    init(juiceMaker: JuiceMaker) {
        self.juiceMaker = juiceMaker
    }
    
    struct Input {
        let viewWillAppear: Driver<Void>
        let strawberryStepperValueChanged: Driver<Double>
        let kiwiStepperValueChanged: Driver<Double>
        let mangoStepperValueChanged: Driver<Double>
        let pineappleStepperValueChanged: Driver<Double>
        let bananaStepperValueChanged: Driver<Double>
    }
    
    struct Output {
        let strawberryValue: Driver<Double>
        let kiwiValue: Driver<Double>
        let mangoValue: Driver<Double>
        let pineappleValue: Driver<Double>
        let bananaValue: Driver<Double>
        let strawberryStepperValueChanged: Driver<Void>
        let kiwiStepperValueChanged: Driver<Void>
        let mangoStepperValueChanged: Driver<Void>
        let pineappleStepperValueChanged: Driver<Void>
        let bananaStepperValueChanged: Driver<Void>
    }
    
    func transform(input: Input) -> Output {
        let trigger =
                self.juiceMaker.fetchAll().asDriver(onErrorJustReturn: [:])

        let strawberryValue = trigger
            .compactMap { $0[.strawberry] }
        let bananaValue = trigger
            .compactMap { $0[.banana] }
        let mangoValue = trigger
            .compactMap { $0[.mango] }
        let kiwiValue = trigger
            .compactMap { $0[.kiwi] }
        let pineappleValue = trigger
            .compactMap { $0[.pineapple] }

        let strawberryStepperValueChanged = Driver.zip(
            strawberryValue,
            input.strawberryStepperValueChanged.map(Int.init).skip(1)
        )
            .map { $0.1 - $0.0 }
            .flatMap {
                self.juiceMaker.modifyStock(fruit: .strawberry, amount: $0)
                    .asDriver(onErrorJustReturn: ())
            }
        let mangoStepperValueChanged = Driver.zip(
            mangoValue,
            input.mangoStepperValueChanged.map(Int.init).skip(1)
        )
            .map { $0.1 - $0.0 }
            .flatMap {
                self.juiceMaker.modifyStock(fruit: .mango, amount: $0)
                    .asDriver(onErrorJustReturn: ())
            }
        let kiwiStepperValueChanged = Driver.zip(
            kiwiValue,
            input.kiwiStepperValueChanged.map(Int.init).skip(1)
        )
            .map { $0.1 - $0.0 }
            .flatMap {
                self.juiceMaker.modifyStock(fruit: .kiwi, amount: $0)
                    .asDriver(onErrorJustReturn: ())
            }
        let bananaStepperValueChanged = Driver.zip(
            bananaValue,
            input.bananaStepperValueChanged.map(Int.init).skip(1)
        )
            .map { $0.1 - $0.0 }
            .flatMap {
                self.juiceMaker.modifyStock(fruit: .banana, amount: $0)
                    .asDriver(onErrorJustReturn: ())
            }
        let pineappleStepperValueChanged = Driver.zip(
            pineappleValue,
            input.pineappleStepperValueChanged.map(Int.init).skip(1)
        )
            .map { $0.1 - $0.0 }
            .flatMap {
                self.juiceMaker.modifyStock(fruit: .pineapple, amount: $0)
                    .asDriver(onErrorJustReturn: ())
            }

        return Output(
            strawberryValue: strawberryValue
                .map(Double.init),
            kiwiValue: kiwiValue
                .map(Double.init),
            mangoValue: mangoValue
                .map(Double.init),
            pineappleValue: pineappleValue
                .map(Double.init),
            bananaValue: bananaValue
                .map(Double.init),
            strawberryStepperValueChanged: strawberryStepperValueChanged,
            kiwiStepperValueChanged: kiwiStepperValueChanged,
            mangoStepperValueChanged: mangoStepperValueChanged,
            pineappleStepperValueChanged: pineappleStepperValueChanged,
            bananaStepperValueChanged: bananaStepperValueChanged
        )
    }
}

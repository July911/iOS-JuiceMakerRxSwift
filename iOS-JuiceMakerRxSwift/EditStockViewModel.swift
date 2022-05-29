//
//  EditStockViewModel.swift
//  iOS-JuiceMakerRxSwift
//
//  Created by 조영민 on 2022/05/30.
//

import Foundation
import RxSwift

final class EditStockViewModel {
    
    private let juiceMaker: JuiceMaker
    
    init(juiceMaker: JuiceMaker) {
        self.juiceMaker = juiceMaker
    }
    
    struct Input {
        let viewWillAppear: Observable<Void>
        let strawberryStepperValueChanged: Observable<Int>
        let kiwiStepperValueChanged: Observable<Int>
        let mangoStepperValueChanged: Observable<Int>
        let pineappleStepperValueChanged: Observable<Int>
        let bananaStepperValueChanged: Observable<Int>
    }
    
    struct Output {
        let strawberryValue: Observable<Int>
        let kiwiValue: Observable<Int>
        let mangoValue: Observable<Int>
        let pineappleValue: Observable<Int>
        let bananaValue: Observable<Int>
    }
    
    func transform(input: Input) -> Output {
        
        
        return Output(
            strawberryValue: <#T##Observable<Int>#>,
            kiwiValue: <#T##Observable<Int>#>,
            mangoValue: <#T##Observable<Int>#>,
            pineappleValue: <#T##Observable<Int>#>,
            bananaValue: <#T##Observable<Int>#>
        )
    }
}

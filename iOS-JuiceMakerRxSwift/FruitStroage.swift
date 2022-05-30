//
//  FruitStroage.swift
//  iOS-JuiceMakerRxSwift
//
//  Created by 조영민, 나무 on 2022/05/29.
//

import Foundation
import RxSwift

final class FruitStorage {
    
    static let shared = FruitStorage()
    private init() { }
    
    private let fruitStore = BehaviorSubject<[Fruit: Int]>(value: [.banana: 10, .mango: 10, .kiwi: 10, .pineapple: 10, .strawberry: 10])
    
    //TODO: 소비 , 현재 재고 , 수정 crud
    
    func update(ingredient: [Fruit: Int]) -> Completable { // subject -> single -> flatMapcompletable
        Completable.create { [weak self] completable in
            guard let currentValue = try? self?.fruitStore.value()
            else {
                completable(.error(StockError.fail))
                return Disposables.create()
            }
            var newStock = currentValue
            var isFail = false
            ingredient.forEach { value in
                guard newStock[value.key]! + value.value >= 0 else {
                    isFail = true
                    return
                }
                newStock[value.key]! += value.value
            }
            if isFail {
                completable(.error(StockError.fail))
            } else {
                self?.fruitStore.onNext(newStock)
                completable(.completed)
            }
            return Disposables.create()
        }
        
    }
    
    func fetchAll() -> Observable<[Fruit: Int]> {
        return self.fruitStore.asObservable()
    }
}

enum StockError: LocalizedError {
    case fail

    var errorDescription: String? {
        return "재고가 부족합니다."
    }
}

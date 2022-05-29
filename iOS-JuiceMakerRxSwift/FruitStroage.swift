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
        return self.fruitStore.asSingle().flatMapCompletable { [weak self] stock -> Completable in
            return Completable.create { completable in
                var each = stock
                ingredient.forEach { value in
                    if each[value.key]! + value.value < 0 {
                        completable(.error(StockError.fail))
                    }
                    each[value.key]! += value.value
                }
                self?.fruitStore.onNext(each)
                completable(.completed)
                
                return Disposables.create()
            }
        }
    }
    
    func notify() -> Observable<[Fruit: Int]> {
        return self.fruitStore.asObservable()
    }
}

enum StockError: Error {
    case fail
}

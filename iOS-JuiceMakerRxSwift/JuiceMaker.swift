//
//  JuiceMaker.swift
//  iOS-JuiceMakerRxSwift
//
//  Created by 조영민, 심재훈 on 2022/05/30.
//

import Foundation
import RxSwift

final class JuiceMaker {
    
    let repository = FruitStorage.shared
    
    func makeJuice(ingredient: Juice) -> Observable<Juice> {
        var juiceRecipe = ingredient.recipe
            juiceRecipe.forEach {
                juiceRecipe.updateValue($0.value * -1, forKey: $0.key)
            }
        return self.repository.update(ingredient: juiceRecipe).andThen(Observable.just(ingredient))
    }
    
    func modifyStock(fruit: Fruit, amount: Int) -> Completable {
        let ingredient = [fruit: amount]
        return self.repository.update(ingredient: ingredient)
    }
    
    func fetchAll() -> Observable<[Fruit: Int]> {
        return self.repository.fetchAll()
    }
}

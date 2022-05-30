//
//  ViewController.swift
//  iOS-JuiceMakerRxSwift
//
//  Created by 조영민 on 2022/05/29.
//

import UIKit
import RxSwift
import RxCocoa

class JuiceOrderViewController: UIViewController {

    var viewModel = JuiceOrderViewModel(juiceMaker: JuiceMaker())
    private let disposeBag = DisposeBag()
    @IBOutlet private weak var strawberryBananaOrderButton: UIButton!
    @IBOutlet private weak var mangoKiwiOrderButton: UIButton!
    @IBOutlet private weak var strawberryOrderButton: UIButton!
    @IBOutlet private weak var bananaOrderButton: UIButton!
    @IBOutlet private weak var mangoOrderButton: UIButton!
    @IBOutlet private weak var kiwiOrderButton: UIButton!
    @IBOutlet private weak var pineappleOrderButton: UIButton!
    @IBOutlet private weak var strawBerryLabel: UILabel!
    @IBOutlet private weak var bananaLabel: UILabel!
    @IBOutlet private weak var mangoLabel: UILabel!
    @IBOutlet private weak var kiwiLabel: UILabel!
    @IBOutlet private weak var pineappleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.binding()
    }

    private func binding() {
        let input = JuiceOrderViewModel.Input(
            viewWillAppear: self.rx.methodInvoked(#selector(UIViewController.viewWillAppear)).map { _ in },
            strawberryOrderButtonDidTapped: self.strawberryOrderButton.rx.tap.asDriver(),
            kiwiOrderButtonDidTapped: self.kiwiOrderButton.rx.tap.asDriver(),
            mangoOrderButtonDidTapped: self.mangoOrderButton.rx.tap.asDriver(),
            pineappleOrderButtonDidTapped: self.pineappleOrderButton.rx.tap.asDriver(),
            bananaOrderButtonDidTapped: self.bananaOrderButton.rx.tap.asDriver(),
            mangoKiwiOrderButtonDidTapped: self.mangoKiwiOrderButton.rx.tap.asDriver(),
            strawberryBananaOrderButtonDidTapped: self.strawberryBananaOrderButton.rx.tap.asDriver()
        )

        let output = self.viewModel.transform(input: input)

        output.strawberryValue
            .drive(self.strawBerryLabel.rx.text)
            .disposed(by: self.disposeBag)
        output.kiwiValue
            .drive(self.kiwiLabel.rx.text)
            .disposed(by: self.disposeBag)
        output.mangoValue
            .drive(self.mangoLabel.rx.text)
            .disposed(by: self.disposeBag)
        output.pineappleValue
            .drive(self.pineappleLabel.rx.text)
            .disposed(by: self.disposeBag)
        output.bananaValue
            .drive(self.bananaLabel.rx.text)
            .disposed(by: self.disposeBag)

        output.orderResult
            .drive {
                self.alert(message: $0)
            }
            .disposed(by: self.disposeBag)
    }

    private func alert(message: String) {
        let alert = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        self.present(alert, animated: true)
    }
}


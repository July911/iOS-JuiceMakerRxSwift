//
//  EditStockViewController.swift
//  iOS-JuiceMakerRxSwift
//
//  Created by 조영민 on 2022/05/29.
//

import UIKit
import RxSwift
import RxCocoa

class EditStockViewController: UIViewController {

    var viewModel = EditStockViewModel(juiceMaker: JuiceMaker())
    private let disposeBag = DisposeBag()
    @IBOutlet weak var strawberryStepper: UIStepper!
    @IBOutlet weak var mangoStepper: UIStepper!
    @IBOutlet weak var kiwiStepper: UIStepper!
    @IBOutlet weak var bananaStepper: UIStepper!
    @IBOutlet weak var pineappleStepper: UIStepper!
    
    @IBOutlet weak var strawberryLabel: UILabel!
    @IBOutlet weak var pineappleLabel: UILabel!
    @IBOutlet weak var kiwiLabel: UILabel!
    @IBOutlet weak var mangoLabel: UILabel!
    @IBOutlet weak var bananaLabel: UILabel!
    
    @IBOutlet weak var closeButtonItem: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.binding()
    }

    private func binding() {
        let input = EditStockViewModel.Input(
            viewWillAppear: self.rx.methodInvoked(#selector(UIViewController.viewWillAppear)).map { _ in }.asDriver(onErrorJustReturn: ()),
            strawberryStepperValueChanged: self.strawberryStepper.rx.value
                .asDriver().debug(),
            kiwiStepperValueChanged: self.kiwiStepper.rx.value.asDriver(),
            mangoStepperValueChanged: self.mangoStepper.rx.value.asDriver(),
            pineappleStepperValueChanged: self.pineappleStepper.rx.value.asDriver(),
            bananaStepperValueChanged: self.bananaStepper.rx.value.asDriver()
        )

        let output = self.viewModel.transform(input: input)

        let disposables: [Disposable] = [
            output.strawberryValue
                .drive(self.strawberryStepper.rx.value),
            self.strawberryStepper.rx.value
                .map { String(Int($0)) }
                .bind(to: self.strawberryLabel.rx.text),
            output.bananaValue
                .drive(self.bananaStepper.rx.value),
            self.bananaStepper.rx.value
                .map { String(Int($0)) }
                .bind(to: self.bananaLabel.rx.text),
            output.kiwiValue
                .drive(self.kiwiStepper.rx.value),
            self.kiwiStepper.rx.value
                .map { String(Int($0)) }
                .bind(to: self.kiwiLabel.rx.text),
            output.mangoValue
                .drive(self.mangoStepper.rx.value),
            self.mangoStepper.rx.value
                .map { String(Int($0)) }
                .bind(to: self.mangoLabel.rx.text),
            output.pineappleValue
                .drive(self.pineappleStepper.rx.value),
            self.pineappleStepper.rx.value
                .map { String(Int($0)) }
                .bind(to: self.pineappleLabel.rx.text),
            output.strawberryStepperValueChanged.drive(),
            output.bananaStepperValueChanged.drive(),
            output.kiwiStepperValueChanged.drive(),
            output.mangoStepperValueChanged.drive(),
            output.pineappleStepperValueChanged.drive(),
            self.closeButtonItem.rx.tap.subscribe(onNext: {
                self.dismiss(animated: true)
            })
        ]
        disposables.forEach { $0.disposed(by: self.disposeBag) }
    }

    private func alert(message: String) {
        let alert = UIAlertController(title: message, message: nil, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        self.present(alert, animated: true)
    }
    
}

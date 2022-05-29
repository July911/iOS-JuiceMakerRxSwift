//
//  EditStockViewController.swift
//  iOS-JuiceMakerRxSwift
//
//  Created by 조영민 on 2022/05/29.
//

import UIKit

class EditStockViewController: UIViewController {
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
}

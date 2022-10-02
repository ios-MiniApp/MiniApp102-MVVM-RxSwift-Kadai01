//
//  ViewController.swift
//  MiniApp102-MVVM&RxSwift-Kadai01
//
//  Created by 前田航汰 on 2022/09/30.
//

import UIKit
import RxSwift
import RxCocoa
import RxRelay

class ViewController: UIViewController {

    @IBOutlet private weak var textField01: UITextField!
    @IBOutlet private weak var textField02: UITextField!
    @IBOutlet private weak var textField03: UITextField!
    @IBOutlet private weak var textField04: UITextField!
    @IBOutlet private weak var textField05: UITextField!
    @IBOutlet private weak var calculationButton: UIButton!
    @IBOutlet private weak var resultLabel: UILabel!

    private let disposeBag = DisposeBag()

    private lazy var viewMoldel = ViewModel(
        textField01Observable: textField01.rx.text.orEmpty.asObservable(),
        textField02Observable: textField02.rx.text.orEmpty.asObservable(),
        textField03Observable: textField03.rx.text.orEmpty.asObservable(),
        textField04Observable: textField04.rx.text.orEmpty.asObservable(),
        textField05Observable: textField05.rx.text.orEmpty.asObservable(),
        calculationButtonObservable: calculationButton.rx.tap.asObservable()
     )

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
    }

    private func setupBindings() {
        viewMoldel.resultPublishRelay.bind(to: resultLabel.rx.text).disposed(by: disposeBag)
    }
}


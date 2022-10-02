//
//  MainViewModel.swift
//  MiniApp102-MVVM&RxSwift-Kadai01
//
//  Created by 前田航汰 on 2022/09/30.
//

import Foundation
import RxSwift
import RxCocoa

protocol ViewModelInputs {
    var textField01Observable: Observable <String> { get }
    var textField02Observable: Observable <String> { get }
    var textField03Observable: Observable <String> { get }
    var textField04Observable: Observable <String> { get }
    var textField05Observable: Observable <String> { get }
    var calculationButtonObservable: Observable <Void> { get }
}

protocol ViewModelOutputs {
    var resultPublishRelay: PublishRelay<String> { get }
}

class ViewModel: ViewModelInputs, ViewModelOutputs {

    // MARK: - Outputs
    var resultPublishRelay = PublishRelay<String>()

    // MARK: - Inputs
    var textField01Observable: Observable <String>
    var textField02Observable: Observable <String>
    var textField03Observable: Observable <String>
    var textField04Observable: Observable <String>
    var textField05Observable: Observable <String>
    var calculationButtonObservable: Observable <Void>

    let calculate = Calculate()

    // MARK: - property
    private var number1 = 0
    private var number2 = 0
    private var number3 = 0
    private var number4 = 0
    private var number5 = 0

    private let disposeBag = DisposeBag()

    init(textField01Observable: Observable<String>,
         textField02Observable: Observable<String>,
         textField03Observable: Observable<String>,
         textField04Observable: Observable<String>,
         textField05Observable: Observable<String>,
         calculationButtonObservable: Observable<Void>) {
        self.textField01Observable = textField01Observable
        self.textField02Observable = textField02Observable
        self.textField03Observable = textField03Observable
        self.textField04Observable = textField04Observable
        self.textField05Observable = textField05Observable
        self.calculationButtonObservable = calculationButtonObservable
        setupBindings()
    }

    private func setupBindings() {

        Observable.combineLatest(
            textField01Observable,
            textField02Observable,
            textField03Observable,
            textField04Observable,
            textField05Observable
        ).subscribe { number1, number2, number3, number4, number5 in
            self.number1 = Int(number1) ?? 0
            self.number2 = Int(number2) ?? 0
            self.number3 = Int(number3) ?? 0
            self.number4 = Int(number4) ?? 0
            self.number5 = Int(number5) ?? 0
        }.disposed(by: disposeBag)

        calculationButtonObservable.asObservable()
            .subscribe(onNext: { [weak self] in

                self?.calculate.addFiveNumbers(
                    number1: self?.number1 ?? 0,
                    number2: self?.number2 ?? 0,
                    number3: self?.number3 ?? 0,
                    number4: self?.number4 ?? 0,
                    number5: self?.number5 ?? 0
                )

                self?.resultPublishRelay.accept(String(self?.calculate.sum ?? 0))

            })
            .disposed(by: disposeBag)
    }

}

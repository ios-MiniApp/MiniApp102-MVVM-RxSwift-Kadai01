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
    var resultPublishSubject: PublishSubject <String> { get }
}

class ViewModel: ViewModelInputs, ViewModelOutputs {

    // MARK: - Outputs
    var resultPublishSubject = PublishSubject<String>()

    // MARK: - Inputs
    var textField01Observable: Observable <String>
    var textField02Observable: Observable <String>
    var textField03Observable: Observable <String>
    var textField04Observable: Observable <String>
    var textField05Observable: Observable <String>
    var calculationButtonObservable: Observable <Void>

    // MARK: - property
    private var number1 = ""
    private var number2 = ""
    private var number3 = ""
    private var number4 = ""
    private var number5 = ""

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
        calculationButtonObservable.asObservable()
            .subscribe(onNext: { [weak self] in
                print("tap")
            })
            .disposed(by: disposeBag)
    }

}

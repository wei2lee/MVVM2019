//
//  SearchResultView.swift
//  MVVM2019June20
//
//  Created by Yee Chuan Lee on 02/07/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import NibDesignable
import RxSwift
import RxCocoa

@IBDesignable
class SearchResultView: NibDesignable {
    var throttleTimeout: DispatchTimeInterval = .milliseconds(2000)
    var minSearchTextCharacter: Int = 3
    @IBOutlet weak var searchTextField: UITextField!
}
extension Reactive where Base : SearchResultView {
    var searchTextDidEndEditing: Driver<String?> {
        return base.searchTextField.rx.text.asDriver()
            .distinctUntilChanged()
            .asVoid()
            .flatMapLatest { _ -> Driver<Void> in
            let a = Driver.just(()).delay(self.base.throttleTimeout)
            let b = self.base.searchTextField.rx.shouldReturn
                .asDriver()
            return Driver.merge(a, b)
                .asObservable()
                .take(1)
                .asDriverOnErrorJustComplete()
        }
        .map { _ in self.base.searchTextField.text }
        .filter { ($0?.count ?? 0) >= self.base.minSearchTextCharacter }
    }
    var searchText: ControlProperty<String?> {
        return base.searchTextField.rx.text
    }
}

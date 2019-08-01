//
//  LoadMoreItemsViewControllerType.swift
//  TestSMS
//
//  Created by UF-FarnKien on 14/05/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol LoadMoreItemsViewControllerType: DisposeBagHolderType {
    var loadMore: PublishSubject<Void> { get }
    func subscribeLoadMore(didLoadMore: Driver<Bool>, tableView: UITableView)
    func subscribeLoadMore(didLoadMore: Driver<Bool>, collectionView: UICollectionView)
}

extension Reactive where Base : LoadMoreItemsViewControllerType {
    var loadMore: Driver<Void> {
        return base.loadMore.asDriverOnErrorJustComplete()
    }
}

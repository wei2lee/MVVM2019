//
//  ReloadItemsViewControllerType.swift
//  TestSMS
//
//  Created by UF-FarnKien on 14/05/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

// MARK: - Reload

protocol ReloadItemsViewControllerType:DisposeBagHolderType {
    var reload: PublishSubject<Void> { get }
    func subscribePullToRefresh(didReload: Driver<Void>, tableView: UITableView)
    func subscribePullToRefresh(didReload: Driver<Void>, scrollView: UIScrollView)
    func subscribePullToRefresh(didReload: Driver<Void>, collectionView: UICollectionView)
}

extension Reactive where Base : ReloadItemsViewControllerType {
    var reload: Driver<Void> {
        return base.reload.asDriverOnErrorJustComplete()
    }
}

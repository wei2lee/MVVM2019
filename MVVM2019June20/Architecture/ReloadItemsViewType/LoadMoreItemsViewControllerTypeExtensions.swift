//
//  LoadMoreItemsViewControllerTypeExtensions.swift
//  TestSMS
//
//  Created by Yee Chuan Lee on 21/05/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import ESPullToRefresh

fileprivate struct LoadMoreItemsViewControllerTypeAssociatedKey {
    static var loadMore = "loadMore"
}

extension LoadMoreItemsViewControllerType {
    var loadMore: PublishSubject<Void> {
        get {
            var ret:PublishSubject<Void>? = getAssociatedObject(self, associativeKey: &LoadMoreItemsViewControllerTypeAssociatedKey.loadMore)
            if ret == nil {
                ret = PublishSubject<Void>()
                setAssociatedObject(self,
                                    value: ret,
                                    associativeKey: &LoadMoreItemsViewControllerTypeAssociatedKey.loadMore,
                                    policy: objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
            return ret!
        }
        set {
            setAssociatedObject(self,
                                value: newValue,
                                associativeKey: &LoadMoreItemsViewControllerTypeAssociatedKey.loadMore,
                                policy: objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    func subscribeLoadMore(didLoadMore: Driver<Bool>, tableView: UITableView) {
        var footer: ESRefreshProtocol & ESRefreshAnimatorProtocol
        footer = ESRefreshFooterAnimator.init(frame: CGRect.zero)
        
        // Scroll up to load more
        tableView.es.addInfiniteScrolling(animator: footer) { [weak self] in
            guard let `self` = self else { return }
            self.loadMore.onNext(())
        }
        
        // Stop pull to refresh
        didLoadMore.drive(onNext: { [weak self] canLoadMore in
            guard self != nil else { return }
            if canLoadMore {
                tableView.es.resetNoMoreData()
                tableView.es.stopLoadingMore()
            } else {
                tableView.es.resetNoMoreData()
                tableView.es.noticeNoMoreData()
            }
        }).disposed(by: self.disposeBag)
    }
    func subscribeLoadMore(didLoadMore: Driver<Bool>, collectionView: UICollectionView) {
        var footer: ESRefreshProtocol & ESRefreshAnimatorProtocol
        footer = ESRefreshFooterAnimator.init(frame: CGRect.zero)
        
        // Scroll up to load more
        collectionView.es.addInfiniteScrolling(animator: footer) { [weak self] in
            guard let `self` = self else { return }
            self.loadMore.onNext(())
        }
        
        // Stop pull to refresh
        didLoadMore.drive(onNext: { [weak self] canLoadMore in
            guard self != nil else { return }
            if canLoadMore {
                collectionView.es.resetNoMoreData()
                collectionView.es.stopLoadingMore()
            } else {
                collectionView.es.resetNoMoreData()
                collectionView.es.noticeNoMoreData()
            }
        }).disposed(by: self.disposeBag)
    }
}

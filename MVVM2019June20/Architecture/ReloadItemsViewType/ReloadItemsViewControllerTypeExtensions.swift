//
//  ReloadItemsViewControllerTypeExtensions.swift
//  TestSMS
//
//  Created by Yee Chuan Lee on 21/05/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import ESPullToRefresh

fileprivate struct ReloadItemsViewControllerTypeAssociatedKey {
    static var reload = "reload"
}

extension ReloadItemsViewControllerType {
    var reload: PublishSubject<Void> {
        get {
            var ret:PublishSubject<Void>? = getAssociatedObject(self, associativeKey: &ReloadItemsViewControllerTypeAssociatedKey.reload)
            if ret == nil {
                ret = PublishSubject<Void>()
                setAssociatedObject(self,
                                    value: ret,
                                    associativeKey: &ReloadItemsViewControllerTypeAssociatedKey.reload,
                                    policy: objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            }
            return ret!
        }
        set {
            setAssociatedObject(self,
                                value: newValue,
                                associativeKey: &ReloadItemsViewControllerTypeAssociatedKey.reload,
                                policy: objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    func subscribePullToRefresh(didReload: Driver<Void>, tableView: UITableView) {
        var header: ESRefreshHeaderAnimator
        header = ESRefreshHeaderAnimator.init(frame: CGRect.zero)
        
        // Pull to refresh
        tableView.es.addPullToRefresh(animator: header) { [weak self] in
            guard let `self` = self else { return }
            self.reload.onNext(())
        }
        
        // Stop pull to refresh
        didReload.drive(onNext: { [weak self, weak header] _ in
            guard self != nil else { return }
            guard header != nil else { return }
            tableView.es.stopPullToRefresh()
        }).disposed(by: self.disposeBag)
    }
    
    func subscribePullToRefresh(didReload: Driver<Void>, scrollView: UIScrollView) {
        var header: ESRefreshHeaderAnimator
        header = ESRefreshHeaderAnimator.init(frame: CGRect.zero)
        
        // Pull to refresh
        scrollView.es.addPullToRefresh(animator: header) { [weak self] in
            guard let `self` = self else { return }
            self.reload.onNext(())
        }
        
        // Stop pull to refresh
        didReload.drive(onNext: { [weak self, weak header] _ in
            guard self != nil else { return }
            guard header != nil else { return }
            scrollView.es.stopPullToRefresh()
        }).disposed(by: self.disposeBag)
    }
    
    func subscribePullToRefresh(didReload: Driver<Void>, collectionView: UICollectionView) {
        var header: ESRefreshHeaderAnimator
        header = ESRefreshHeaderAnimator.init(frame: CGRect.zero)
        
        // Pull to refresh
        collectionView.es.addPullToRefresh(animator: header) { [weak self] in
            guard let `self` = self else { return }
            self.reload.onNext(())
        }
        
        // Stop pull to refresh
        didReload.drive(onNext: { [weak self, weak header] _ in
            guard self != nil else { return }
            guard header != nil else { return }
            collectionView.es.stopPullToRefresh()
        }).disposed(by: self.disposeBag)
    }
}

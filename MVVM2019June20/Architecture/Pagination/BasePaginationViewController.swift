//
//  BasePaginationViewController.swift
//  TestSMS
//
//  Created by UF-FarnKien on 07/05/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import SwifterSwift

class BasePaginationViewController<VM>: BaseViewController<VM>, BasePaginationViewType where VM: (BaseViewModel&BasePaginationViewModelType) {
    //MARK: Outlets
    @IBOutlet weak var listView: UITableView!
    
    //State
    var dataSource: RxTableViewSectionedReloadDataSource<VM.SM>!
    
    //MARK: View Cycle
    override func loadView() {
        super.loadView()
    }
    override func dispose() {
        super.dispose()
        dataSource = nil
    }
    //MARK: setupView
    override func setupView() {
        super.setupView()
        setupListView()
    }
    
    func setupListView() {
        //tableView.register(nibWithCellClass: ViewFormListTableViewCell.self)
        dataSource = RxTableViewSectionedReloadDataSource<VM.SM>(configureCell: self.configureCell)
    }
    
    func removePullToReload() {
        listView.es.removeRefreshHeader()
    }
    
    func removePullToLoadMore() {
        listView.es.removeRefreshFooter()
    }
    
    //MARK: setupTransformInput
    override func setupTransformInput() {
        super.setupTransformInput()
        viewModel.startReload = self.rx.reload
        viewModel.startLoadMore = self.rx.loadMore
    }
    
    //MARK: subscribe
    override func subscribe() {
        super.subscribe()
        subscribePullToRefresh(didReload: viewModel.didReload, tableView: self.listView)
        subscribeLoadMore(didLoadMore: viewModel.didLoadMore, tableView: self.listView)
        subscribeListView(sections: viewModel.sections)
    }
    
    func subscribeListView(sections: Driver<[VM.SM]>) {
        sections
            .asObservable()
            .bind(to: self.listView.rx.items(dataSource: self.dataSource))
            .disposed(by: disposeBag)
    }

    func configureCell(ds: TableViewSectionedDataSource<VM.SM>, tv: UITableView, ip: IndexPath, item: VM.SM.Item) -> UITableViewCell {
        
        return UITableViewCell()
    }
}

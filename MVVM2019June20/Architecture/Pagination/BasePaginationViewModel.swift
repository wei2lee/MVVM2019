//
//  BasePaginationViewModel.swift
//  TestSMS
//
//  Created by UF-FarnKien on 06/05/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources

protocol BasePaginationViewModelType {
    associatedtype SM : SectionModelType
    associatedtype FM
    //MARK: Input
    var filterDidBeginEditing: Driver<Void> { get }
    var filterDidEndEditing: Driver<Void> { get }
    var itemSelected: Driver<IndexPath> { get }
    //MARK: Output
    var filterModel: BehaviorRelay<FM>! { get }
    var sections: Driver<[SM]> { get }
    var didReload: Driver<Void> { get }
    var didLoadMore: Driver<Bool> { get }
    var view:(BasePaginationViewType)? { set get }
}

class BasePaginationViewModel<Res, SM, FM> : BaseViewModel, BasePaginationViewModelType where SM: SectionModelType {
    //MARK: Input
    @ViewEvent var filterDidBeginEditing: Driver<Void> = .never()
    @ViewEvent var filterDidEndEditing: Driver<Void> = .never()
    @ViewEvent var itemSelected: Driver<IndexPath> = .never()
    var searchText = BehaviorRelay<String?>(value: nil)
    @ViewEvent var searchTextDidEndEditing: Driver<Void> = .never()
    //MARK: Output
    var filterModel: BehaviorRelay<FM>!
    @PresentationBinding var sections: Driver<[SM]> = .never()
    @PresentationBinding var didReload: Driver<Void> = .never()
    @PresentationBinding var didLoadMore: Driver<Bool> = .never()

    weak var view:(BasePaginationViewType)? = nil
    //MARK: State - Pagingation
    var listItemsRelay: BehaviorRelay<[SM.Item]> = BehaviorRelay<[SM.Item]>(value: [])
    var sectionsRelay: BehaviorRelay<[SM]> = BehaviorRelay<[SM]>(value: [])
    var pageIndex: Int = 0
    var pageSize:Int = 10
    var enableLoadMore: Bool = true
    var canLoadMore: BehaviorRelay<Bool> = BehaviorRelay<Bool>(value: false)
    //MARK: State -
    var loadMoreTracker = StopEventTracker()
    var reloadTracker = StopEventTracker()
    internal var subclassDidFinishLoadMore: Driver<Bool> = Driver.never()
    //MARK: Initializer
    required override init() {
        super.init()
    }
    //MARK: Dependency
    
    override func transform() {
        super.transform()
        
        let modelOnStartLoad = Driver.merge(self.searchTextDidEndEditing,
                                            self.startLoad,
                                            self.filterDidEndEditing)
            .flatMap({
                return self.getStartLoadData()
            })
            .do(onNext: self.resetAsFirstPage)

        let modelOnReload = startReload
            .flatMap({
                return self.getReloadData()
            })
            .do(onNext: self.resetAsFirstPage)

        let modelOnLoadMore = startLoadMore.flatMap(getLoadMoreData)
            .do(onNext: self.appendPage)

        self.didReload = reloadTracker.asDriver()
        self.didLoadMore = self.canLoadMore.asDriver()
        let createSections = self.createSections()
        self.sections = sectionsRelay.asDriver()

        showError = transformErrorHandling(input: ErrorHandlingInput(view: view, errorTracker: errorTracker))

        //MARK: subscribe
        disposeBag.insert(
            createSections.drive(sectionsRelay),
            modelOnStartLoad.debug("yy").drive(),
            modelOnReload.drive(),
            modelOnLoadMore.drive()
        )
    }
    
    override func dispose() {
        super.dispose()
    }
    //MARK: Helper - Pagination
    func appendPage(output: Res) {
        let items = mapResponseToItems(output: output)
        if items.count >= pageSize {
            listItemsRelay.accept(listItemsRelay.value + items)
            pageIndex += 1
            canLoadMore.accept(enableLoadMore)
        } else if items.count > 0 {
            listItemsRelay.accept(listItemsRelay.value + items)
            pageIndex += 1
            canLoadMore.accept(false)
        } else {
            listItemsRelay.accept(listItemsRelay.value + items)
            //pageIndex += 1
            canLoadMore.accept(false)
        }
    }
    
    func resetAsFirstPage(output: Res) {
        let items = mapResponseToItems(output: output)
        if items.count >= pageSize {
            listItemsRelay.accept(items)
            pageIndex = 1
            canLoadMore.accept(enableLoadMore)
        } else {
            //No more data to load
            listItemsRelay.accept(items)
            pageIndex = 1
            canLoadMore.accept(false)
        }
    }
    
    //MARK: -
    func createSections() -> Driver<[SM]> {
        return self.listItemsRelay.asDriver().map(self.createSections)
    }
    //WARNING: Abstract function, subclass should implement it
    func mapResponseToItems(output: Res) -> [SM.Item] {
        return []
    }
    
    //WARNING: Abstract function, subclass should implement it
    func createSections(list: [SM.Item]) -> [SM] {
        return []
    }
    
    //WARNING: Abstract function, subclass should implement it
    func getStartLoadData() -> Driver<Res> {
        return Driver.never()
        //track errro
        //track activity
        //dont track stop event
    }
    
    //WARNING: Abstract function, subclass should implement it
    func getReloadData() -> Driver<Res> {
        return Driver.never()
        //track errro
        //also dont track activity
        //track stop event for reload
    }
    
    //WARNING: Abstract function, subclass should implement it
    func getLoadMoreData() -> Driver<Res> {
        return Driver.never()
        //track errro
        //also dont track activity
        //track stop event for load more
    }
}

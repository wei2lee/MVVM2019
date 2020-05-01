//
//  MovieListViewController.swift
//  MVVM2019June20
//
//  Created by Yee Chuan Lee on 01/07/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import SwifterSwift
import RxBiBinding

class MovieListViewController: BasePaginationCollectionViewController<MovieListViewModel>, MovieListViewType, PinterestFlowLayoutDelegate {
    //IBOutlet
    @IBOutlet var searchResultView: SearchResultView!
    //state
    
    //view life cycle
    //MARK: View Cycle
    override func loadView() {
        super.loadView()
        viewModel ??= MovieListViewModel()
        viewModel.disposed(by: disposeBag)
    }
    //setupView
    override func setupListView() {
        super.setupListView()
        listView.collectionViewLayout = {
            let ret = PinterestFlowLayout(delegate: self,
                                          numberOfColumns: 1,
                                          cellLeftRightPadding: 0,
                                          cellTopBottomPadding: 0)
            return ret
        }()
        listView.register(nibWithCellClass: MovieCardCollectionViewCell.self)
    }
    //transform
    override func setupTransformInput() {
        super.setupTransformInput()
        viewModel.startLoad = rx.viewWillAppearForFirstTime
        viewModel.searchTextDidEndEditing = searchResultView.rx.searchTextDidEndEditing.asVoid().debug("load api")
        disposeBag.insert(
            searchResultView.rx.searchText <-> viewModel.searchText
        )
    }
    //subscribe
    override func subscribe() {
        super.subscribe()
    }
    override func configureCell(ds: CollectionViewSectionedDataSource<MovieSection>, tv: UICollectionView, ip: IndexPath, item: MovieItem) -> UICollectionViewCell {
        let cell = tv.dequeueReusableCell(withClass: MovieCardCollectionViewCell.self, for: ip)
        cell.viewModel = item
        cell.disposeBag.insert(
            cell.rx.shareDidTap.asObservable().bind(to: viewModel.shareDidTap),
            cell.rx.rateDidTap.asObservable().bind(to: viewModel.rateDidTap),
            cell.rx.posterDidTap.asObservable().bind(to: viewModel.posterDidTap),
            cell.rx.cardContentDidTap.asObservable().bind(to: viewModel.cardContentDidTap)
        )
        return cell
    }
    //helper
    
    //MARK: <MovieListViewType>
    func routeToMovieDetail(intent: MovieIntent) {
        let screen = DI.resolver.resolve(MovieViewControllerType.self)!
        screen.intent = intent
        navigationController?.pushViewController(screen)
    }
    //MARK: <PinterestFlowLayoutDelegate>
    fileprivate let sizingCell:MovieCardCollectionViewCell! = {
        return UINib(nibName: MovieCardCollectionViewCell.typeName, bundle: nil)
            .instantiate(withOwner: nil, options: nil).first as? MovieCardCollectionViewCell
        
    }()
    func collectionView(heightForCellAtIndexPath indexPath: IndexPath, withWidth width: CGFloat) -> CGFloat {
        let columnWidth = width
        let item = self.dataSource[indexPath.section].items[indexPath.row]
        let cell = sizingCell!
        let size = CGSize(width: columnWidth, height: 10)
        cell.frame.size = size
        cell.viewModel = item
        
        let fittingSize: CGSize = CGSize(width: columnWidth, height: UIView.layoutFittingCompressedSize.height)
        let verticalFittingPriority: UILayoutPriority = UILayoutPriority(rawValue: Float(1))
        
        let desiredSize = cell.contentView.systemLayoutSizeFitting(fittingSize,
                                                                    withHorizontalFittingPriority: .required,
                                                                   verticalFittingPriority: verticalFittingPriority)
        return desiredSize.height
    }
    func collectionView(estimatedHeightForCellAtIndexPath indexPath: IndexPath, withWidth width: CGFloat) -> CGFloat {
        return 196
    }
}


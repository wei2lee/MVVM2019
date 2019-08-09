//
//  MovieCardCollectionViewCell.swift
//  MVVM2019June20
//
//  Created by Yee Chuan Lee on 02/07/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import UIKit
import TagListView
import RxSwift
import RxCocoa
import RxGesture

class MovieCardCollectionViewCell: UICollectionViewCell {
    //Container
    @IBOutlet weak var rootView: UIView!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var paddingView: UIView!
    //Poster
    @IBOutlet weak var posterView: UIView!
    @IBOutlet weak var posterImageView: UIImageView!
    //CardContent
    @IBOutlet weak var cardContentView: UIView!
    //CardContent - Header
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var tagsView: TagListView!
    //CardContent - Body
    @IBOutlet weak var bodyView: UIView!
    @IBOutlet weak var bodyLabel: UILabel!
    //CardContent - Footer
    @IBOutlet weak var footerView: UIView!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var rateButton: UIButton!
    //
    override func prepareForReuse() {
        dispose()
    }
    
    override func awakeFromNib() {
        
    }
    
    var viewModel: MovieCardCellViewModel? {
        didSet {
            dispose()
            if let viewModel = viewModel {
                //Poster
                posterImageView.kf.setImage(with: viewModel.posterImageURL)
                //CardContent - Header
                titleLabel.text = viewModel.headerTitleText
                subTitleLabel.text = viewModel.headerSubTitleText
                tagsView.removeAllTags()
                if let headerTagText = viewModel.headerTagText {
                    tagsView.addTag(headerTagText)
                }
                //CardContent - Body
                bodyLabel.attributedText = viewModel.bodyText
            }
        }
    }
}

extension Reactive where Base : MovieCardCollectionViewCell {
    var shareDidTap: Driver<MovieCardCellViewModel> {
        return base.shareButton.rx.tap.asDriver().map { _ in self.base.viewModel! }
    }
    var rateDidTap: Driver<MovieCardCellViewModel> {
        return base.rateButton.rx.tap.asDriver().map { _ in self.base.viewModel! }
    }
    var posterDidTap: Driver<MovieCardCellViewModel> {
        return base.posterImageView.rx.tapGesture().when(.recognized).asDriverOnErrorJustComplete().asVoid().map { _ in self.base.viewModel! }
    }
    var cardContentDidTap: Driver<MovieCardCellViewModel> {
        return base.cardContentView.rx.tapGesture().when(.recognized).asVoid().asDriverOnErrorJustComplete().map { _ in self.base.viewModel! }
    }
    var didTap: Driver<MovieCardCellViewModel> {
        return base.cardView.rx.tapGesture().when(.recognized).asVoid().asDriverOnErrorJustComplete().map { _ in self.base.viewModel! }
    }
}

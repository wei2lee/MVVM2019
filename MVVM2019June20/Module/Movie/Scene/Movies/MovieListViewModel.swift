//
//  MovieListViewModel.swift
//  MVVM2019June20
//
//  Created by Yee Chuan Lee on 01/07/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import RxSwift
import RxCocoa
import RxDataSources

final class MovieListViewModel: BasePaginationViewModel<OMDb.ResponseSearchMovie, MovieSection, ()> {
    //Input
    let rateDidTap = PublishRelay<MovieItem>()
    let shareDidTap = PublishRelay<MovieItem>()
    let posterDidTap = PublishRelay<MovieItem>()
    let cardContentDidTap = PublishRelay<MovieItem>()
    //Initialize
    required init() {
        super.init()
        self.pageSize = -1
        self.enableLoadMore = false
    }
    //Transform
    override func transform() {
        super.transform()
        let startRate = self.rateDidTap.asDriverOnErrorJustComplete()
            .flatMap({ item in
                self.view!.presentDialog(title: "Rate Movie",
                                         message: "Rate this movie \(item.headerTitleText.orEmpty) ?",
                    actions: [.negative(), .positive()])
            }).filter { $0.kind == .positive }
            .withLatestFrom(self.rateDidTap.asDriverOnErrorJustComplete())
            .flatMap { self.rate($0).asDriverOnErrorJustComplete() }
        
        let startShare = self.shareDidTap.asDriverOnErrorJustComplete()
            .flatMap({ item in
                self.view!.presentDialog(title: "Share Movie",
                                         message: "Share this movie \(item.headerTitleText.orEmpty) ?",
                    actions: [.negative(), .positive()])
            }).filter { $0.kind == .positive }
            .withLatestFrom(self.shareDidTap.asDriverOnErrorJustComplete())
            .flatMap { self.share($0).asDriverOnErrorJustComplete() }
        
        let routeToDetail = self.cardContentDidTap.asDriverOnErrorJustComplete()
            .map({ item -> MovieIntent in
                return MovieIntent(id: (item.movieSearchResult?.imdbID).orEmpty)
            }).do(onNext: { intent in
                (self.view as! MovieListViewType).routeToMovieDetail(intent: intent)
            })
        //Subscribe
        disposeBag.insert(
            startRate.drive(),
            startShare.drive(),
            routeToDetail.drive()
        )
    }
    //Helper
    override func mapResponseToItems(output: OMDb.ResponseSearchMovie) -> [MovieItem] {
        return (output.search ?? []).map { response -> MovieItem in
            var ret = MovieItem()
            //Poster
            ret.posterImageURL = response.poster.flatMap { URL(string:$0) }
            //CardContent - Header
            ret.headerTitleText = response.title
            ret.headerSubTitleText = nil
            ret.headerTagText = response.type
            //CardContent - Body
            ret.bodyText = {
                let s: String
                if Int.random(in: 0...1) == 0 {
                    s = "Toy Story is about the 'secret life of toys' when people are not around. When Buzz Lightyear, a space-ranger, takes Woody's place as Andy's favorite toy, Woody doesn't like the situation and gets into a fight with Buzz."
                } else {
                    s = "Toy Story is about the"
                }
                return NSAttributedString(string: s)
            }()
            //State
            ret.movieSearchResult = response
            return ret
        }
    }
    
    override func createSections(list: [MovieItem]) -> [MovieSection] {
        return [SectionModel<String, MovieItem>.init(model: "", items: list)]
    }
    
    //Model
    func rate(_ item: MovieItem) -> Observable<Void> {
        let api = Observable<Void>.just(()).delay(.milliseconds(2000), scheduler: MainScheduler.instance)
        return api
            .trackActivity(activityIndicator)
            .trackError(errorTracker)
    }
    
    func share(_ item: MovieItem) -> Observable<Void> {
        let api = Observable<Void>.just(()).delay(.milliseconds(2000), scheduler: MainScheduler.instance)
        return api
            .trackActivity(activityIndicator)
            .trackError(errorTracker)
    }
    
    override func getStartLoadData() -> Driver<OMDb.ResponseSearchMovie> {
        var input = OMDb.RequestSearchMovie()
        input.s = self.searchText.value ?? ""
        if input.s.isNilOrEmpty {
            return .empty()
        }
        let api = OMDb.EndPoint.SearchMovie(input: input).request()
        return api
            .trackActivity(activityIndicator)
            .trackError(errorTracker)
            .asDriverOnErrorJustComplete()
    }
    
    
    override func getReloadData() -> Driver<OMDb.ResponseSearchMovie> {
        var input = OMDb.RequestSearchMovie()
        input.s = self.searchText.value ?? ""
        let api = OMDb.EndPoint.SearchMovie(input: input).request()
        return api
            .trackActivity(activityIndicator)
            .trackStopEvent(reloadTracker)
            .trackError(errorTracker)
            .asDriverOnErrorJustComplete()
    }
    
    
    override func getLoadMoreData() -> Driver<OMDb.ResponseSearchMovie> {
        var input = OMDb.RequestSearchMovie()
        input.s = self.searchText.value ?? ""
        let api = OMDb.EndPoint.SearchMovie(input: input).request()
        return api
            .trackActivity(activityIndicator)
            .trackStopEvent(loadMoreTracker)
            .trackError(errorTracker)
            .asDriverOnErrorJustComplete()
    }
}


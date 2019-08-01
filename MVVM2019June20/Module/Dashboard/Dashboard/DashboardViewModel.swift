//
//  DashboardViewModel.swift
//  MVVM2019June20
//
//  Created by Yee Chuan Lee on 19/07/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class DashboardViewModel: BaseViewModel {
    //MARK: Input
    var movieListDidTap: Driver<Void> = .never()
    var profileDidTap: Driver<Void> = .never()
    var logoutDidTap: Driver<Void> = .never()
    var loginOtherUserDidTap: Driver<Void> = .never()
    var lockDidTap: Driver<Void> = .never()
    //MARK: Output
    weak var view: DashboardViewType? = nil
    //MARK: initializer
    //MARK: Dependency
    @Injected fileprivate var authService: AuthServiceType
    //MARK: transform
    override func transform() {
        super.transform()
        let routeToMovieList = self.movieListDidTap
            .do(onNext:{ self.view?.routeToMovieList() })
        
        let routeToProfile = self.profileDidTap
            .do(onNext:{ self.view?.routeToProfile() })
        
        let routeToLogout = self.logoutDidTap
            .flatMapLatest(self.logout)
            .do(onNext:{ self.view?.routeToLogout() })
        
        let promptLogin = self.loginOtherUserDidTap
            .do(onNext:{ self.view?.promptLoginModal() })
        
        let promptLock = self.lockDidTap
            .do(onNext:{ self.view?.promptLockModal() })
        //subscribe
        disposeBag.insert(
            routeToMovieList.drive(),
            routeToProfile.drive(),
            routeToLogout.drive(),
            promptLogin.drive(),
            promptLock.drive()
        )
    }
    //MARK: helper
    fileprivate func logout() -> Driver<Void> {
        return authService.logout(loginSession: .current, catchErrorJustNext: true)
            .trackActivity(activityIndicator)
            .asDriverOnErrorJustComplete()
            .asVoid()
    }
}

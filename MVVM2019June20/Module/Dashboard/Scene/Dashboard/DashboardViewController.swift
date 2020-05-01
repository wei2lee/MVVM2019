//
//  DashboardViewController.swift
//  MVVM2019June20
//
//  Created by Yee Chuan Lee on 19/07/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import UIKit
import SwifterSwift

class DashboardViewController: BaseViewController<DashboardViewModel> {
    //MARK: outlets
    @IBOutlet var movieListButton: UIButton!
    @IBOutlet var logoutButton: UIButton!
    @IBOutlet var profileButton: UIButton!
    @IBOutlet var loginOtherUserButton: UIButton!
    @IBOutlet var lockScreenButton: UIButton!
    
    override func loadView() {
        super.loadView()
        viewModel = DI.resolver.resolve(DashboardViewModel.self)!
    }
    
    override func setupView() {
        super.setupView()
        navigationItem.title = "Dashboard"
    }
    
    override func setupTransformInput() {
        super.setupTransformInput()
        viewModel.view = self
        viewModel.movieListDidTap = movieListButton.rx.tap.asDriver()
        viewModel.profileDidTap = profileButton.rx.tap.asDriver()
        viewModel.logoutDidTap = logoutButton.rx.tap.asDriver()
        viewModel.loginOtherUserDidTap = loginOtherUserButton.rx.tap.asDriver()
        viewModel.lockDidTap = lockScreenButton.rx.tap.asDriver()
    }
}
extension DashboardViewController: DashboardViewType {
    func routeToMovieList() {
        let screen = DI.resolver.resolve(MovieListViewControllerType.self)!
        navigationController?.pushViewController(screen)
    }
    func routeToLogout() {
        let screen = DI.resolver.resolve(LoginNavigationControllerType.self)!
        SwifterSwift.sharedApplication.keyWindow!.rootViewController = screen
    }
    func routeToProfile() {
        
    }
    func promptLoginModal() {
        var screen = DI.resolver.resolve(LoginNavigationControllerType.self)!
        screen.intent = LoginNavigationIntent(isModal: true,
                                              initialView: .login,
                                              enableDismiss: true)
        self.present(screen, animated: true, completion: nil)
    }
    func promptLockModal() {
        var screen = DI.resolver.resolve(LoginNavigationControllerType.self)!
        screen.intent = LoginNavigationIntent(isModal: true,
                                              initialView: .login,
                                              enableDismiss: false)
        self.present(screen, animated: true, completion: nil)
    }
}

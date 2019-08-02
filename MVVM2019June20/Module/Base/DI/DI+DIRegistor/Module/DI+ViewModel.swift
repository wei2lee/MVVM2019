//
//  DI+Dashboard+ViewModel.swift
//  MVVM2019June20
//
//  Created by Yee Chuan Lee on 19/07/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import Foundation

extension DI {
    struct ViewModel: DIRegistor {
        static func register() {
            Login.register()
            Dashboard.register()
            Movie.register()
            Splash.register()
        }
        struct Login : DIRegistor {
            static func register() {
                DI.container.register(LoginViewModel.self) { (r, intent: LoginIntent) in
                    return LoginViewModel(intent: intent)
                }
                DI.container.register(ActivationViewModel.self) { r in
                    return ActivationViewModel()
                }
            }
        }
        struct Dashboard : DIRegistor {
            static func register() {
                DI.container.register(DashboardViewModel.self) { r in
                    return DashboardViewModel()
                }
            }
        }
        struct Movie : DIRegistor {
            static func register() {
                DI.container.register(MovieListViewModel.self) { r in
                    return MovieListViewModel()
                }
                DI.container.register(MovieViewModel.self) { (r, intent: MovieIntent) in
                    return MovieViewModel(intent: intent)
                }
            }
        }
        struct Splash : DIRegistor {
            static func register() {
                DI.container.register(SplashViewModel.self) { (r) in
                    return SplashViewModel()
                }
            }
        }
    }
}


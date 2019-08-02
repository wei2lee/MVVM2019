//
//  DI+Dashboard+View.swift
//  MVVM2019June20
//
//  Created by Yee Chuan Lee on 19/07/2019.
//  Copyright © 2019 Yee Chuan Lee. All rights reserved.
//

import Foundation
import SwifterSwift
import Swinject

extension DI {
    struct View: DIRegistor {
        static func register() {
            Login.register()
            Dashboard.register()
            Movie.register()
            Splash.register()
        }
        struct Login : DIRegistor {
            static func register() {
                let storyboard = UIStoryboard(name: "Login", bundle: nil)
                DI.container.register(LoginNavigationControllerType.self) { r -> LoginNavigationControllerType in
                    return storyboard.instantiateViewController(withIdentifier: "LoginNavigationController")
                }
                DI.container.register(LoginViewControllerType.self) { r -> LoginViewControllerType in
                    return storyboard.instantiateViewController(withIdentifier: "LoginViewController")
                }
                DI.container.register(ActivationViewControllerType.self) { r -> ActivationViewControllerType in
                    return storyboard.instantiateViewController(withIdentifier: "ActivationViewController")
                }
            }
        }
        struct Dashboard : DIRegistor {
            static func register() {
                let storyboard = UIStoryboard(name: "Dashboard", bundle: nil)
                DI.container.register(DashboardNavigationControllerType.self) { r -> DashboardNavigationControllerType in
                    return storyboard.instantiateViewController(withIdentifier: "DashboardNavigationController")
                }
                DI.container.register(DashboardViewControllerType.self) { r -> DashboardViewControllerType in
                    return storyboard.instantiateViewController(withIdentifier: "DashboardViewController")
                }
            }
        }
        struct Movie : DIRegistor {
            static func register() {
                let storyboard = UIStoryboard(name: "Movie", bundle: nil)
                DI.container.register(MovieViewControllerType.self) { r -> MovieViewControllerType in
                    return storyboard.instantiateViewController(withIdentifier: "MovieViewController")
                }
                DI.container.register(MovieListViewControllerType.self) { r -> MovieListViewControllerType in
                    return storyboard.instantiateViewController(withIdentifier: "MovieListViewController")
                }
            }
        }
        struct Splash : DIRegistor {
            static func register() {
                let storyboard = UIStoryboard(name: "Splash", bundle: nil)
                DI.container.register(SplashViewControllerType.self) { r -> SplashViewControllerType in
                    return storyboard.instantiateViewController(withIdentifier: "SplashViewController")
                }
            }
        }
    }
}


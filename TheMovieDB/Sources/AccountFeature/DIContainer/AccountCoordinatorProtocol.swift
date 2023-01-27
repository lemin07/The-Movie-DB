//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 22.01.2023.
//

import UIKit
import Common
import MovieListFeatureInterface

protocol AccountCoordinatorProtocol: AnyObject {
    func navigate(with state: AccountState)
}

public enum AccountState: State {
    case accountFeatureInit
    case signInIsPicked(url: URL, delegate: AuthPermissionViewModelDelegate?)
    case authorizationIsComplete
}

protocol AccountCoordinatorDependencies {
    func buildAuthPermissionViewController(url: URL, delegate: AuthPermissionViewModelDelegate?) -> AuthPermissionViewController
    func buildAccountViewController(coordinator: AccountCoordinatorProtocol?) -> UIViewController
}

public enum AccountChildCoordinator {
    case movieList
}

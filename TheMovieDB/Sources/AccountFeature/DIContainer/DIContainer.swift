//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 22.01.2023.
//

import UIKit
import Common
import MovieListFeatureInterface

final class DIContainer {
    
    private let dependencies: ModuleDependencies
    
    private lazy var authRepository: AuthRepository = {
      return DefaultAuthRepository(
        remoteDataSource: DefaultAuthRemoteDataSource(dataTransferService: dependencies.apiDataTransferService),
        requestTokenRepository: dependencies.requestTokenRepository,
        accessTokenRepository: dependencies.accessTokenRepository,
        tokenMapper: RequestTokenMapper(authenticateBaseURL: dependencies.authenticateBaseURL)
      )
    }()

    private lazy var accountRepository: AccountRepository = {
      return DefaultAccountRepository(
        remoteDataSource: DefaultAccountRemoteDataSource(dataTransferService: dependencies.apiDataTransferService),
        accessTokenRepository: dependencies.accessTokenRepository,
        userLoggedRepository: dependencies.userLoggedRepository,
        gravatarBaseURL: dependencies.gravatarBaseURL
      )
    }()
    
    private var interactor: AccountInteractorProtocol?
    
    init(dependencies: ModuleDependencies) {
        self.dependencies = dependencies
        
        func makeCreateSessionUseCase() -> CreateSessionUseCase {
          return DefaultCreateSessionUseCase(authRepository: authRepository)
        }
     
        func makeFetchAccountDetailsUseCase() -> FetchAccountDetailsUseCase {
          return DefaultFetchAccountDetailsUseCase(accountRepository: accountRepository)
        }

        func makeFetchLoggedUserUseCase() -> FetchLoggedUser {
          return DefaultFetchLoggedUser(loggedRepository: dependencies.userLoggedRepository)
        }

        func makeDeleteLoggedUserUseCase() -> DeleteLoggedUserUseCase {
          return DefaultDeleteLoggedUserUseCase(loggedRepository: dependencies.userLoggedRepository)
        }
        interactor = AccountInteractor(createNewSession: makeCreateSessionUseCase(),
                                       fetchAccountDetails: makeFetchAccountDetailsUseCase(),
                                       fetchLoggedUser: makeFetchLoggedUserUseCase(),
                                       deleteLoggedUser: makeDeleteLoggedUserUseCase())
        
        let viewModel = AccountViewModel(interactor: interactor!)
    }
    
    func buildModuleCoordinator(navigationController: UINavigationController) -> Coordinator {
        return AccountCoordinator(navigationController: navigationController, dependencies: self)
    }
}

extension DIContainer: AccountCoordinatorDependencies {
    func buildAccountViewController(coordinator: AccountCoordinatorProtocol?) -> UIViewController {

        return AccountViewController()
    }
}

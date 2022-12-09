//
//  AuthCoordinator.swift
//  The-Movie-DB
//
//  Created by LEMIN DAHOVICH on 01.11.2022.
//
import UIKit

protocol LoginCoordinatorProtocol: Coordinator {
    func showLoginViewController()
    func showAuth()
}

final class LoginCoordinator: LoginCoordinatorProtocol {
    
    weak var finishDelegate: CoordinatorFinishDelegate?
    
    var navigationController: UINavigationController
    
    var childCoordinators: [Coordinator] = []
    
    var type: CoordinatorType { .login }
        
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
        
    func start() {
        showLoginViewController()
    }
    
    deinit {
        print("LoginCoordinator deinit")
    }
    
    func showLoginViewController() {
        let loginVC: LoginController = LoginController()
        loginVC.coordinator = self
        navigationController.pushViewController(loginVC, animated: true)
    }
    
    func showAuth(){
        let coordinator = AuthPermissionCoordinator(navigationController)
        coordinator.start()
    }
}

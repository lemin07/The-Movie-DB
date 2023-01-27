//
//  AccountViewController.swift
//  
//
//  Created by LEMIN DAHOVICH on 22.01.2023.
//

import UIKit
import Combine
import UI

protocol AccountViewControllerFactory {
  func makeSignInViewController() -> UIViewController
  func makeProfileViewController(with account: Account) -> UIViewController
}

class AccountViewController: UIViewController {

    private let viewModel: AccountViewModelProtocol
    private let viewControllersFactory: AccountViewControllerFactory
    private var currentChildViewController: UIViewController?
    private var disposeBag = Set<AnyCancellable>()
    
    init(viewModel: AccountViewModelProtocol, viewControllersFactory: AccountViewControllerFactory) {
        self.viewControllersFactory = viewControllersFactory
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        view = UIView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .blue
    }
    
}

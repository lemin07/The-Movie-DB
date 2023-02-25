//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 23.01.2023.
//

import UIKit
import Combine
import Common
import UI

import UIKit

class MovieDetailViewController: UIViewController, Loadable {

  private var rootView: MovieDetailRootView?

  private lazy var favoriteButton: UIBarButtonItem = {
    return UIBarButtonItem()
  }()

  private lazy var watchListButton: UIBarButtonItem = {
    return UIBarButtonItem()
  }()

  private var disposeBag = Set<AnyCancellable>()

  // MARK: - Initializer
  init(viewModel: MovieDetailViewModelProtocol) {
    self.viewModel = viewModel
    super.init()
  }

  override func loadView() {
    rootView = MovieDetailRootView(viewModel: viewModel)
    view = rootView
  }

  // MARK: - Life Cycle
  override func viewDidLoad() {
    super.viewDidLoad()

    setupNavigationBar()
    setupViewModel()
    viewModel.viewDidLoad()
  }

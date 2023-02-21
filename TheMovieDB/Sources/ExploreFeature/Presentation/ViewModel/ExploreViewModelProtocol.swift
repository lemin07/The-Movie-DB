//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 21.02.2023.
//

import Foundation
import Foundation
import Combine
import Common
import UI

protocol ExploreViewModelProtocol {
    // MARK: - Input
    func viewDidLoad()
    func willDisplayItem(_ item: Int, outOf totalRows: Int)
    func movieIsPicked(index: Int)
    func refreshView()
    
    // MARK: - Output
    var viewStateObservableSubject: CurrentValueSubject<SimpleViewState<MovieCellViewModel>, Never> { get }
}


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
    func movieIsPicked(index: Int)
    func moviesByGenre(id: Int, title: String)
    
    // MARK: - Output
    var viewStateObservableSubject: CurrentValueSubject<SimpleViewState<MovieCellViewModel>, Never> { get }
}


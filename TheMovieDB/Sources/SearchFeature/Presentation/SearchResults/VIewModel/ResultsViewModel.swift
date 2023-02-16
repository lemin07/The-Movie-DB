//
//  File.swift
//  
//
//  Created by LEMIN DAHOVICH on 16.02.2023.
//
import Foundation
import Combine
import Common
import UI
import Persistance

final class ResultsViewModel: ResultsViewModelProtocol {
    
    private let searchMovieUseCase: SearchMovieUseCase
    private let fetchRecentSearchesUseCase: FetchSearchesUseCase
    private let currentSearchSubject = CurrentValueSubject<String, Never>("")
    
    let viewState  = CurrentValueSubject<ResultViewState, Never>(.initial)
    let dataSource = CurrentValueSubject<[ResultsSectionModel], Never>([])
    
    weak var delegate: ResultsViewModelDelegate?
    private var bag = Set<AnyCancellable>()
    
    private var currentResult: [MoviePage.Movie] = []
    
    init(searchMovieUseCase: SearchMovieUseCase,
         fetchRecentSearchesUseCase: FetchSearchesUseCase
    ) {
        self.searchMovieUseCase = searchMovieUseCase
        self.fetchRecentSearchesUseCase = fetchRecentSearchesUseCase
        subscribeToSearchInput()
        subscribeToRecents()
    }
    
    func recentSearchIsPicked(query: String) {
        delegate?.resultsSearchViewModel(self, recentSearchSelected: query)
    }
    
    func movieIsPicked(id: Int) {
        delegate?.resultsSearchViewModel(self, selectedMovie: id)
    }
    
    func searchMovie(with query: String) {
        currentSearchSubject.send(query)
    }
    
    func resetSearch() {
        viewState.send(.initial)
    }
    
    func getViewState() -> ResultViewState {
        return viewState.value
    }
    
    private func subscribeToRecents() {
      viewState
        .removeDuplicates()
        .filter { $0 == .initial }
        .flatMap { [fetchRecentSearchesUseCase] _ -> AnyPublisher<[Search], ErrorEnvelope> in
          return fetchRecentSearchesUseCase.execute(requestValue: FetchSearchesUseCaseRequestValue())
        }
        .receive(on: DispatchQueue.main)
        .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] results in
          self?.createSectionModel(recentSearches: results.map { $0.query }, resultsMovies: [])
        })
        .store(in: &bag)
    }
    
    private func fetchMovies(with query: String) {
        viewState.send(.loading)
        createSectionModel(recentSearches: [], resultsMovies: [])
        
        let request = SearchMovieUseCaseRequestValue(query: query, page: 1)
        
        searchMovieUseCase.execute(requestValue: request)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case let .failure(error):
                    self?.viewState.send(.error(error.localizedDescription))
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] result in
                self?.processFetched(for: result)
            })
            .store(in: &bag)
    }
    
    private func processFetched(for response: MoviePage) {
        if response.results.isEmpty {
            viewState.send(.empty)
        } else {
            viewState.send(.populated)
        }
        currentResult = response.results
        createSectionModel(recentSearches: [], resultsMovies: response.results)
    }
    
    private func createSectionModel(recentSearches: [String], resultsMovies: [MoviePage.Movie]) {
        let recentSearchsItem = recentSearches.map { ResultsSectionItem.recentSearchs(items: $0) }
        
        let resultsMovieItem = resultsMovies
            .map { MovieCellViewModel(show: $0) }
            .map { ResultsSectionItem.results(items: $0) }
        
        var sectionModel: [ResultsSectionModel] = []
        
        if !recentSearchsItem.isEmpty {
            sectionModel.append(.recentSearchs(items: recentSearchsItem))
        }
        
        if !resultsMovieItem.isEmpty {
            sectionModel.append(.results(items: resultsMovieItem))
        }
        dataSource.send(sectionModel)
    }
    
    private func subscribeToSearchInput() {
        currentSearchSubject
            .filter { !$0.isEmpty }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in }, receiveValue: { [weak self] query in
                self?.fetchMovies(with: query)
            })
            .store(in: &bag)
    }
}
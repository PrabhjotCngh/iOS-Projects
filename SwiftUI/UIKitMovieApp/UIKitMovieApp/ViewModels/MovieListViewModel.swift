//
//  MovieListViewModel.swift
//  UIKitMovieApp
//
//  Created by M_2195552 on 2024-02-11.
//

import Foundation
import Combine

class MovieListViewModel {
    
    // Private properties
    @Published private(set) var movies: [Movie] = []
    private var cancellables: Set<AnyCancellable> = []
    private var service: HTTPClientService

    // Internal properties
    @Published var isLoading: Bool = true
    
    // Subjects
    private var searchSubject = CurrentValueSubject<String, Never>("")

    init(service: HTTPClientService) {
        self.service = service
        setupSearchPublisher()
    }
    
    var moviesCount: Int {
        movies.count
    }
    
    func setSearchText(_ searchText: String) {
        searchSubject.send(searchText)
    }
    
    //MARK: - Private functions
    
    private func setupSearchPublisher() {
        searchSubject
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .sink { [weak self] searchText in
                guard let self = self else { return }
                self.loadMovies(search: searchText)
            }.store(in: &cancellables)
    }
    
    private func loadMovies(search: String) {
        service.fetchMovies(searchString: search).sink { [weak self] completion in
            guard let self = self else { return }

            switch completion {
            case .finished:
                self.isLoading = false
            case .failure(let error):
                print(error)
            }
        } receiveValue: { [weak self] movies in
            guard let self = self else { return }
            self.movies = movies
        }.store(in: &cancellables)

    }

}

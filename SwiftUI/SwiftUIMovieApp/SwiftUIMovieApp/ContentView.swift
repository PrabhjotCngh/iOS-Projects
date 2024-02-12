//
//  ContentView.swift
//  SwiftUIMovieApp
//
//  Created by M_2195552 on 2024-02-11.
//

import SwiftUI
import Combine

struct ContentView: View {
    @State private var movies: [Movie] = []
    @State private var search: String = ""
    
    private var service: HTTPClientService
    
    private var searchSubject = CurrentValueSubject<String, Never>("")
    @State private var cancellables: Set<AnyCancellable> = []

    init(service: HTTPClientService) {
        self.service = service
    }
    
    //MARK: - Private functions
    private func setupSearchPublisher() {
        searchSubject
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .sink { searchText in
                loadMovies(search: searchText)
            }.store(in: &cancellables)
    }
    
    private func loadMovies(search: String) {
        service.fetchMovies(searchString: search).sink { completion in

            switch completion {
            case .finished:
                print("Finished")
            case .failure(let error):
                print(error)
            }
        } receiveValue: { movies in
            self.movies = movies
        }.store(in: &cancellables)

    }
    
    //MARK: - Body
    var body: some View {
        List(movies) { movie in
            HStack {
                AsyncImage(url: movie.poster) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 75, height: 75)
                } placeholder: {
                    ProgressView()
                }
                Text(movie.title)
            }
        }
        .onAppear {
            setupSearchPublisher()
        }
        .searchable(text: $search)
        .onChange(of: search) {
            searchSubject.send(search)
        }
        .overlay {
            if movies.isEmpty {
                ContentUnavailableView.search(text: search)
            }
        }
    }
}

#Preview {
    NavigationStack {
        ContentView(service: HTTPClientFactory.create())
    }
}

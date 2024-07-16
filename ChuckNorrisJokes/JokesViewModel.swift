//
//  JokesViewModel.swift
//  ChuckNorrisJokes
//
//  Created by Mehmet Ali Bunsuz on 16.07.2024.
//

import Foundation

class JokeViewModel: ObservableObject {
    @Published var joke: ChuckNorrisJoke?
    @Published var isLoading = false
    @Published var errorMessage: String?

    func fetchJoke() {
        guard let url = URL(string: "https://api.chucknorris.io/jokes/random") else { return }

        isLoading = true
        errorMessage = nil
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                self.isLoading = false
            }

            if let error = error {
                DispatchQueue.main.async {
                    self.errorMessage = "Failed to fetch joke: \(error.localizedDescription)"
                }
                return
            }

            guard let data = data else {
                DispatchQueue.main.async {
                    self.errorMessage = "No data received."
                }
                return
            }

            do {
                let joke = try JSONDecoder().decode(ChuckNorrisJoke.self, from: data)
                DispatchQueue.main.async {
                    self.joke = joke
                }
            } catch {
                DispatchQueue.main.async {
                    self.errorMessage = "Failed to decode joke: \(error.localizedDescription)"
                }
            }
        }.resume()
    }
}

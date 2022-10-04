//
//  AsyncAwaitProblemView.swift
//  Problems
//
//  Created by Atsushi Yamamoto on 2022/10/02.
//

import SwiftUI

struct AsyncAwaitProblemView: View {
    @State var jokesTextWithoutAsyncAwait = ""
    @State var jokesTextWithAsyncAwait = ""
    @State var jokesTextWithParalellAsyncAwait = ""
    
    var body: some View {
        VStack(spacing: 12) {
            VStack {
                HStack {
                    Text("Without async/await")
                    Button("Fetch 2 jokes") {
                        jokesTextWithoutAsyncAwait = "Jokes come here..."
                        
                        let jokeFetcher = JokeFetcher()
                        jokeFetcher
                            .fetchJokeWithoutAsyncAwait { result in
                                switch result {
                                case let .success(jokeResponse1):
                                    jokeFetcher
                                        .fetchJokeWithoutAsyncAwait { result in
                                            DispatchQueue.main.async {
                                                switch result {
                                                case let .success(jokeResponse2):
                                                    jokesTextWithoutAsyncAwait = "Joke 1: \(jokeResponse1.setup)\nJoke 2: \(jokeResponse2.setup)"
                                                case let .failure(error):
                                                    print(error.localizedDescription)
                                                }
                                            }
                                        }
                                case let .failure(error):
                                    print(error.localizedDescription)
                                }
                            }
                    }
                }
                Text(jokesTextWithoutAsyncAwait)
            }
            
            VStack {
                HStack {
                    Text("With async/await")
                    Button("Fetch 2 jokes") {
                        let jokeFetcher = JokeFetcher()
                        
                        Task {
                            jokesTextWithAsyncAwait = "Jokes come here..."
                            
                            let jokeResponse1 = try await jokeFetcher
                                .fetchJokeWithAsyncAwait(index: 1)
                            let jokeResponse2 = try await jokeFetcher
                                .fetchJokeWithAsyncAwait(index: 2)
                            
                            jokesTextWithAsyncAwait = "Joke 1: \(jokeResponse1.setup)\nJoke 2: \(jokeResponse2.setup)"
                        }
                    }
                }
                Text(jokesTextWithAsyncAwait)
            }
            
            VStack {
                HStack {
                    Text("With parallel async/await")
                    Button("Fetch 2 jokes") {
                        let jokeFetcher = JokeFetcher()
                        
                        Task {
                            jokesTextWithParalellAsyncAwait = "Jokes come here..."
                            
                            async let jokeResponse1 = try jokeFetcher
                                .fetchJokeWithAsyncAwait(index: 1)
                            async let jokeResponse2 = try jokeFetcher
                                .fetchJokeWithAsyncAwait(index: 2)
                            
                            let jokes = try await [jokeResponse1, jokeResponse2]
                            
                            jokesTextWithParalellAsyncAwait = jokes
                                .enumerated()
                                .map { index, joke in
                                    "Joke \(index + 1): \(joke.setup)"
                                }
                                .joined(separator: "\n")
                        }
                    }
                }
                Text(jokesTextWithParalellAsyncAwait)
            }
        }
        .padding(.horizontal, 16)
    }
}

private struct JokeFetcher {
    let url = URL(string: "https://official-joke-api.appspot.com/random_joke")!
    
    func fetchJokeWithoutAsyncAwait(completion: @escaping (Result<JokeResponse, Error>) -> Void) {
        URLSession.shared
            .dataTask(with: url) { data, response, error in
                if let error = error {
                    return completion(.failure(error))
                }
                
                guard let data = data else { return }
                
                do {
                    let decoder = JSONDecoder()
                    let jokeResponse = try decoder.decode(JokeResponse.self, from: data)
                    completion(.success(jokeResponse))
                } catch {
                    completion(.failure(error))
                }
            }
            .resume()
    }
    
    func fetchJokeWithAsyncAwait(index: Int) async throws -> JokeResponse {
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        return try decoder.decode(JokeResponse.self, from: data)
    }
}

private struct JokeResponse: Decodable {
    let id: Int
    let type: String
    let setup: String
    let punchline: String
}

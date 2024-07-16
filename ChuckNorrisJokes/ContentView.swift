//
//  ContentView.swift
//  ChuckNorrisJokes
//
//  Created by Mehmet Ali Bunsuz on 16.07.2024.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel = JokeViewModel()

    var body: some View {
           VStack {
               Text("Jokes App")
                   .bold()
                   .padding()
                   .font(.system(size: 45))
                   
               Spacer()
               if viewModel.isLoading {
                   ProgressView("Loading joke...")
                       .padding()
               } else if let errorMessage = viewModel.errorMessage {
                   Text(errorMessage)
                       .foregroundColor(.red)
                       .padding()
               } else if let joke = viewModel.joke {
                   VStack {

                       AsyncImage(url: URL(string: joke.iconURL)) { image in
                           image.resizable()
                       } placeholder: {
                           ProgressView()
                       }
                       .frame(width: 100, height: 100)
                       .clipShape(Circle())

                       Text(joke.value)
                           .font(.headline)
                           .padding()

                       if !joke.categories.isEmpty {
                           Text("Categories: \(joke.categories.joined(separator: ", "))")
                               .font(.subheadline)
                               .foregroundColor(.secondary)
                       }

                       Text("Created At: \(joke.createdAt)")
                           .font(.subheadline)
                           .foregroundColor(.secondary)
                   }
                   .padding()
               }

               Button(action: {
                   viewModel.fetchJoke()
               }) {
                   Text("Fetch New Joke")
                       .padding()
                       .background(Color.black)
                       .foregroundColor(.white)
                       .cornerRadius(8)
               }
               .padding()
               Spacer()
           }
           .onAppear {
               viewModel.fetchJoke()
           }
       }
   }

#Preview {
    ContentView()
}

//
//  Network.swift
//  RedactedViewModifier
//
//  Created by Neftali Samarey on 9/24/22.
//
// ObservableObject: Changes in this class will automatically be reflected on our views using it.

import SwiftUI

class Network: ObservableObject {

    @Published var content: [Post] = []
    @Published var album: [Album] = []
    @Published var user: User = User()
    @Published var isLoading: Bool = true

    func getContentRequest() {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else {
            return
        }

        let urlRequest = URLRequest(url: url)

        let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                print("Error loading data: \(error)")

                return
            }

            guard let response = response as? HTTPURLResponse else {
                return
            }

            if response.statusCode == 200 {
                guard let data = data else {
                    return
                }

                DispatchQueue.main.async {
                    do {
                        let decodedContent = try JSONDecoder().decode([Post].self, from: data)

                        // assing to data array
                        self.content = decodedContent

                    } catch let error {
                        print("Error: \(error)")
                    }
                }
            }
        }

        dataTask.resume()
    }

    func fetchUsers() {
        guard let url = URL(string: "https://dummyjson.com/users") else {
            return
        }

        let urlRequest = URLRequest(url: url)

        let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                print("Error loading data: \(error)")

                return
            }

            guard let response = response as? HTTPURLResponse else {
                return
            }

            if response.statusCode == 200 {
                guard let data = data else {
                    return
                }

                DispatchQueue.main.async {
                    do {
                        let decodedContent = try JSONDecoder().decode(User.self, from: data)

                        self.user = decodedContent
                        self.isLoading = false

                    } catch let error {
                        print("Error: \(error)")
                    }
                }
            }
        }

        dataTask.resume()
    }
}

//
//  NetworkManager.swift
//  H4X0R News
//
//  Created by Sera on 2/22/20.
//  Copyright © 2020 Sera. All rights reserved.
//

import Foundation

class NetworkManager: ObservableObject { // broadcast its properties to third parties: observableObject
    
    @Published var posts = [Post]() // whenever it changes, notify the listeners: @published
    
    func fetchData() {
        if let url = URL(string: "http://hn.algolia.com/api/v1/search?tags=front_page") {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) {(data, response, error) in
                if let e = error {
                    print(e.localizedDescription)
                } else if let safeData = data {
                    self.parseJSON(safeData)
                    
                }
            }
            task.resume()
        }
    }
    func parseJSON(_ data: Data) {
        
        let decoder = JSONDecoder()
        do{
            let results = try decoder.decode(Results.self, from: data)
            DispatchQueue.main.async {
                self.posts = results.hits
            }
                
        } catch {
            print(error.localizedDescription)
        }
    }
    
}

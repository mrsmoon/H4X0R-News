//
//  ContentView.swift
//  H4X0R News
//
//  Created by Sera on 2/22/20.
//  Copyright © 2020 Sera. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var networkManager = NetworkManager() // subscribing the update from the networkManager
    //whenever thereis an update, it is triggered!
    
    var body: some View {
        NavigationView {
            List(networkManager.posts) {post in
                NavigationLink(destination: DetailView(url: post.url)) {
                    Text(String(post.points))
                    Text(post.title)
                }
            }
            .navigationBarTitle("H4X0R NEWS")
        } // as viewDidLoad()
        .onAppear {
            self.networkManager.fetchData()
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



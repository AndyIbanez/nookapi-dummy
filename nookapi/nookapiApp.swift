//
//  nookapiApp.swift
//  nookapi
//
//  Created by Andy Ibanez on 3/7/22.
//

import SwiftUI

class NookAPI<CP: ClothesProvider>: ObservableObject {
    let clothesProvider: CP
    
    init(clothesProvider: CP) {
        self.clothesProvider = clothesProvider
    }
}

fileprivate let baseURL = URL(string: "https://api.nookipedia.com")!
fileprivate let apiKey = "401a9b3f-4bdd-48b3-bbcf-ecd900aa7b4f"
fileprivate let networkingExecutor = NetworkExecutor(baseURL: baseURL, apiKey: apiKey)

fileprivate let clothesProvider = ClothesProviderNetworking(networkingExecutor: networkingExecutor)
//fileprivate let clothesProvider = ClothesProviderOpenInitializer()
@main
struct nookapiApp: App {
    @StateObject private var nookAPI = NookAPI(clothesProvider: clothesProvider)
    
    var body: some Scene {
        WindowGroup {
            ClothesListView(clothesProvider: nookAPI.clothesProvider)
                .onAppear {
                    let fileUrl = Bundle.main.url(forResource: "My Catalog", withExtension: "json")!
                    jsonSerializationPrinting(file: fileUrl)
                }
        }
    }
}

//
//  ClothesListView.swift
//  nookapi
//
//  Created by Andy Ibanez on 3/12/22.
//

import SwiftUI

// I myself don't know why it has to be (Identifiable & ClothesProtocol), because ClothesProtocol is already Identifiable.
// But the compiler doesn't like that, so specifying Identifiable is necessary.
@MainActor
class ClothesListViewViewModel<CP: ClothesProvider>: ObservableObject where CP.ClothesType: (Identifiable & ClothesProtocol) {
    
    @Published private(set) var clothes: [CP.ClothesType] = []
    @Published private(set) var loadingStatus: LoadingStatus = .idle
    
    var clothesProvider: CP?
    
    func loadClothes() {
        Task {
            do {
                loadingStatus = .loading
                let parameters = ClothesRequestParameters()
                let fetchedClothes = try await clothesProvider?.fetchClothes(parameters: parameters)
                self.clothes = fetchedClothes ?? []
                loadingStatus = .idle
            } catch {
                print(error)
            }
        }
    }
}

struct ClothesListView<CP: ClothesProvider>: View where CP.ClothesType: (Identifiable & ClothesProtocol) {
    @StateObject private var viewModel = ClothesListViewViewModel<CP>()
    
    var clothesProvider: CP
    
    init(clothesProvider: CP) {
        self.clothesProvider = clothesProvider
    }
    
    var shouldShowLoadingIndicator: Bool {
        switch viewModel.loadingStatus {
        case .loading: return true
        default: return false
        }
    }
    
    var shouldShowNoClothesLabel: Bool {
        (!shouldShowLoadingIndicator) && viewModel.clothes.isEmpty
    }
    
    var body: some View {
        ZStack(alignment: .center) {
            VStack {
                List(viewModel.clothes) { clothes in
                    Text(clothes.name)
                }
                .opacity(shouldShowLoadingIndicator ? 0 : 1)
                .animation(.default, value: viewModel.clothes)
                Spacer()
                if !shouldShowLoadingIndicator {
                    Button("Load clothes") {
                        viewModel.loadClothes()
                    }
                    .transition(.opacity)
                    .animation(.default, value: viewModel.clothes)
                }
            }
        }
        .onAppear {
            if viewModel.clothesProvider == nil {
                viewModel.clothesProvider = clothesProvider
            }
        }
        .overlay(alignment: .center) {
            Text("No clothes")
                .opacity(shouldShowNoClothesLabel ? 1 : 0)
                .animation(.default, value: viewModel.clothes)
            ProgressView()
                .opacity(shouldShowLoadingIndicator ? 1 : 0)
                .animation(.default, value: viewModel.clothes)
        }
    }
}

struct ClothesListView_Previews: PreviewProvider {
    static var clothesProvider = ClothesProviderOpenInitializer()
    
    static var previews: some View {
        ClothesListView(clothesProvider: clothesProvider)
    }
}

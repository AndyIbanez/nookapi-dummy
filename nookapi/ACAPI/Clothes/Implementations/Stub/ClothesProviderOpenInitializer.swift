//
//  ClothesProviderOpenInitializer.swift
//  nookapi
//
//  Created by Andy Ibanez on 3/12/22.
//

import Foundation

class ClothesProviderOpenInitializer: ClothesProvider {
    typealias ClothesType = ClothesOpenInitializer
    
    func fetchClothes(parameters: ClothesRequestParameters) async throws -> [ClothesType] {
        await Task.sleep(3_000_000_000)
        return [
            .init(
                name: "3D Glasses",
                category: .accessories,
                sell: 122,
                totalVariations: 2,
                villagerEquipable: true,
                seasonality: .allYear,
                versionAdded: .v1_0_0,
                unlocked: true,
                notes: "",
                labelThemes: [.party],
                styles: [.active],
                availability: [
                    .init(from: "Able Sisters", note: "")
                ], buy: [
                    .init(price: 490, currency: .bells)
                ], variations: [
                    .init(
                        variation: "White",
                        imageURL: URL(string: "https://dodo.ac/np/images/1/15/3D_Glasses_%28White%29_NH_Icon.png")!,
                        colors: [
                            .white,
                            .colorful
                        ])
                ])
        ]
    }
}

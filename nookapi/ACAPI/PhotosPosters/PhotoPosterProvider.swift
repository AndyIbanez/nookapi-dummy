//
//  PhotoPosterProvider.swift
//  nookapi
//
//  Created by Andy Ibanez on 3/13/22.
//

import Foundation

protocol PhotoPosterProvider {
    associatedtype PhotoPosterType
    
    func fetchPhotoPosters(parameters: PhotoPostersRequestParameters) async throws -> [PhotoPosterType]
}

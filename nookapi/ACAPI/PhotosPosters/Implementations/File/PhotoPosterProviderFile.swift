//
//  PhotoPosterProviderFile.swift
//  nookapi
//
//  Created by Andy Ibanez on 3/13/22.
//

import Foundation

class PhotoPosterProviderFile: PhotoPosterProvider {
    typealias PhotoPosterType = PhotoPosterCodable
    
    let fileURL: URL
    let decoder: JSONDecoder
    
    init(fileURL: URL, decoder: JSONDecoder = JSONDecoder()) {
        self.fileURL = fileURL
        self.decoder = decoder
    }
    
    func fetchPhotoPosters(parameters: PhotoPostersRequestParameters) async throws -> [PhotoPosterCodable] {
        let data = try Data(contentsOf: fileURL)
        let photoPosters = try decoder.decode([PhotoPosterCodable].self, from: data)
        return photoPosters
    }
}

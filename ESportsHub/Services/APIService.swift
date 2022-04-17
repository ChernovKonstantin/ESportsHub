//
//  APIService.swift
//  GitSearchSwiftUI
//
//  Created by Константин Чернов on 18.01.2022.
//

import Foundation
import SwiftUI
import UIKit

struct APIService {
    func makeRequest<T:Decodable>(request: APIRequest) async throws -> T {
        do {
            let (data, response) = try await URLSession.shared.data(for: request.asURLRequest())
            guard (response as? HTTPURLResponse)?.statusCode == 200 else {
                throw APIError.responseStatusError }
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            do {
                let decodedData = try decoder.decode(T.self, from: data)
                return decodedData
            } catch {
                throw APIError.decoderError
            }
        } catch {
            throw APIError.dataTaskError
        }
    }
    
    func loadImage(url: String) async throws -> UIImage {
        guard let url = URL(string: url) else { throw APIError.dataTaskError }
        let (data, response) = try await URLSession.shared.data(from: url)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else { throw APIError.responseStatusError }
        guard let image = UIImage(data: data)
        else { throw APIError.imageDataError }
        return image
    }
}

//
//  MatchesViewModel.swift
//  ESportsHub
//
//  Created by Константин Чернов on 23.02.2022.
//

import SwiftUI

class MatchesViewModel: ObservableObject {
    @Published var matches: [DotaMatchModel] = []
    @Published var cachedImages: [Int: UIImage] = [:]
    
    @MainActor
    func fetchMatches() async {
        let apiService = APIService()
        do {
            let response: [DotaMatchModel] = try await apiService.makeRequest(request: .matches)
            self.matches.append(contentsOf: response.filter { $0.opponents.count > 0 })
        } catch  {
            print(error.localizedDescription)
        }
    }
    
    @MainActor
    func fetchImage(for opponents: [DotaOpponentsModel?]) async {
        for opponent in opponents {
            guard let team = opponent?.opponent,
                  let imageURL = team.imageUrl,
                  cachedImages[team.id] == nil
            else { break }
            
            let apiService = APIService()
            do {
                let image = try await apiService.loadImage(url: imageURL)
                self.cachedImages[team.id] = image
            } catch {
                print(error.localizedDescription)
            }
        }
        
        //        guard let first = opponents.first?.opponent,
        //              let second = opponents.last?.opponent else {
        //                  return
        //              }
//        guard cachedImages[first.id] == nil else { return }
//        let apiService = APIService()
//        do {
//            let image = try await apiService.loadImage(url: first)
//            self.cachedImages[imageID] = image
//        } catch {
//            print(error.localizedDescription)
//        }
    }
}

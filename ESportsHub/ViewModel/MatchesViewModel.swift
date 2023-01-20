//
//  MatchesViewModel.swift
//  ESportsHub
//
//  Created by Константин Чернов on 23.02.2022.
//

import SwiftUI
import Combine

class MatchesViewModel: ObservableObject {
    @Published var matches: [DotaMatchModel] = []
    private var upcomingMatches: [DotaMatchModel] = []
    private var runningMatches: [DotaMatchModel] = []
    private var pastMatches: [DotaMatchModel] = []
    @Published var cachedImages: [Int: UIImage] = [:]
    @Published var pickedMatchesStatus = RequestFilterStatus.upcoming
    private var initialLoad = true
    
    var cancellable = Set<AnyCancellable>()
    
    init() {
        subscibe()
    }
    
    @MainActor
    func fetchMatches() async {
        guard initialLoad else { return }
        let apiService = APIService()
        do {
            let upcomingResponse: [DotaMatchModel] = try await apiService.makeRequest(request: .upcomingMatches)
            self.upcomingMatches.append(contentsOf: upcomingResponse.filter { $0.opponents.count > 1 })
            if initialLoad {
                matches = upcomingMatches
                initialLoad.toggle()
            }
            let runningResponse: [DotaMatchModel] = try await apiService.makeRequest(request: .runningMatches)
            self.runningMatches.append(contentsOf: runningResponse.filter { $0.opponents.count > 1 })
            let pastResponse: [DotaMatchModel] = try await apiService.makeRequest(request: .pastMatches)
            self.pastMatches.append(contentsOf: pastResponse.filter { $0.opponents.count > 1 })
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
    
    func subscibe() {
        $pickedMatchesStatus
            .sink(receiveValue: { [self] value in
                switch value {
                case .upcoming: matches = upcomingMatches
                case .running: matches = runningMatches
                case .past: matches = pastMatches
                }
            })
            .store(in: &cancellable)
    }
}

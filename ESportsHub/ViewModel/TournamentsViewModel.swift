//
//  TournamentsViewModel.swift
//  ESportsHub
//
//  Created by Константин Чернов on 09.05.2022.
//

import SwiftUI
import Combine

class TournamentsViewModel: ObservableObject {
    @Published var tournaments: [DotaTournamentModel] = []
    private var upcomingTournaments: [DotaTournamentModel] = []
    private var runningTournaments: [DotaTournamentModel] = []
    private var pastTournaments: [DotaTournamentModel] = []
//    @Published var cachedImages: [Int: UIImage] = [:]
    @Published var pickedMatchesStatus = RequestFilterStatus.upcoming
    private var initialLoad = true
    
    var cancellable = Set<AnyCancellable>()
    
    init() {
        subscibe()
    }
    
    @MainActor
    func fetchTournaments() async {
        let apiService = APIService()
        do {
            let upcomingResponse: [DotaTournamentModel] = try await apiService.makeRequest(request: .upcomingTournaments)
            self.upcomingTournaments.append(contentsOf: upcomingResponse)
            if initialLoad {
                tournaments = upcomingTournaments
                initialLoad.toggle()
            }
            let runningResponse: [DotaTournamentModel] = try await apiService.makeRequest(request: .runningTournaments)
            self.runningTournaments.append(contentsOf: runningResponse)
            let pastResponse: [DotaTournamentModel] = try await apiService.makeRequest(request: .pastTournaments)
            self.pastTournaments.append(contentsOf: pastResponse)
        } catch  {
            print(error.localizedDescription)
        }
    }
    
//    @MainActor
//    func fetchImage(for opponents: [DotaOpponentsModel?]) async {
//        for opponent in opponents {
//            guard let team = opponent?.opponent,
//                  let imageURL = team.imageUrl,
//                  cachedImages[team.id] == nil
//            else { break }
//
//            let apiService = APIService()
//            do {
//                let image = try await apiService.loadImage(url: imageURL)
//                self.cachedImages[team.id] = image
//            } catch {
//                print(error.localizedDescription)
//            }
//        }
//    }
    
    func subscibe() {
        $pickedMatchesStatus
            .sink(receiveValue: { [self] value in
                switch value {
                case .upcoming: tournaments = upcomingTournaments
                case .running: tournaments = runningTournaments
                case .past: tournaments = pastTournaments
                }
            })
            .store(in: &cancellable)
    }
}

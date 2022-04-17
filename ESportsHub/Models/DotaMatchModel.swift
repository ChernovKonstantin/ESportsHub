//
//  DotaMatchModel.swift
//  ESportsHub
//
//  Created by Константин Чернов on 23.02.2022.
//

import Foundation

struct DotaMatchModel: Codable, Identifiable {
    var id: Int
    var live: LiveMatchModel
    var name: String
    var matchType: String
    var numberOfGames: Int
    var scheduledAt: String
    var league: DotaLeagueModel
    var serie: DotaSerieModel
    var opponents: [DotaOpponentsModel]
    
    struct LiveMatchModel: Codable {
        var supported: Bool
    }
    
    struct DotaLeagueModel: Codable {
        var name: String
    }

    struct DotaSerieModel: Codable {
        var fullName: String
    }
}

struct DotaOpponentsModel: Codable {
    var opponent: DotaOpponentModel
}

struct DotaOpponentModel: Codable, Identifiable {
    var id: Int
    var name: String
    var imageUrl: String?
}

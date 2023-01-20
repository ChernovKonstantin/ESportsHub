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
    var status: String
    var liveEmbedUrl: String?
    var results: [MatchResult]
    
    struct MatchResult: Codable {
        var score: Int
        var teamId: Int
    }
    
    struct LiveMatchModel: Codable {
        var supported: Bool
    }
}

struct DotaLeagueModel: Codable {
    var name: String
}

struct DotaSerieModel: Codable {
    var fullName: String
}

enum GameStatus: String, Codable, RawRepresentable {
    case finished, running, canceled, postponed
    case notStarted = "not_started"
}

struct DotaOpponentsModel: Codable {
    var opponent: DotaOpponentModel
}

struct DotaOpponentModel: Codable, Identifiable {
    var id: Int
    var name: String
    var imageUrl: String?
    var acronym: String?
}

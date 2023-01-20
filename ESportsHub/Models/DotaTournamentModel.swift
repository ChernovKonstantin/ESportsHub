//
//  DotaTournamentModel.swift
//  ESportsHub
//
//  Created by Константин Чернов on 09.05.2022.
//

import Foundation

struct DotaTournamentModel: Codable, Identifiable {
    var id: Int
    var name: String
    var league: DotaLeagueModel
    var serie: DotaSerieModel
    var beginAt: String
    var winnerId: Int?
    var teams: [DotaOpponentModel]
    
}

//
//  TournamentsDetailsView.swift
//  ESportsHub
//
//  Created by Константин Чернов on 09.05.2022.
//

import SwiftUI

struct TournamentsDetailsView: View {
    var tournament: DotaTournamentModel
    
    var body: some View {
        VStack {
            if let winnerId = tournament.winnerId,
               let winner = tournament.teams.first(where: {$0.id == winnerId}) {
                Text("Winner: " + winner.name)
            }
        }
    }
}

struct TournamentsDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ProgressView()
    }
}

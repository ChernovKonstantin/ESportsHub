//
//  MatchDetailsView.swift
//  ESportsHub
//
//  Created by Константин Чернов on 27.04.2022.
//

import SwiftUI

struct MatchDetailsView: View {
    var match: DotaMatchModel
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.gray.opacity(0.1))
            VStack {
                if match.status != GameStatus.notStarted.rawValue,
                   let firstOpp = match.opponents.first?.opponent,
                   let secondOpp = match.opponents.last?.opponent {
                    HStack {
                        Text((firstOpp.acronym ?? firstOpp.name))
                        Text("\(match.results.first(where: {$0.teamId == firstOpp.id})?.score ?? 0)")
                        Text(" - ")
                        Text("\(match.results.first(where: {$0.teamId == secondOpp.id})?.score ?? 0)")
                        Text(secondOpp.acronym ?? secondOpp.name)
                    }
                }
                
                Text("\(match.matchType) \(match.numberOfGames)"
                    .replacingOccurrences(of: "_", with: " ")
                    .capitalized
                )
                Text(match.league.name)
                Text(match.serie.fullName)
//                Text(getFormattedDate(input: match.scheduledAt))
                Text(match.scheduledAt.getFormattedDate())
                
                if match.status == GameStatus.running.rawValue,
                   let liveEmbedUrl = match.liveEmbedUrl,
                   let url = URL(string: liveEmbedUrl) {
                    Link(destination: url) {
                        Text("Watch online on Twitch")
                    }
                }
            }
            .padding()
        }
        .padding(.trailing)
        .padding(.leading)
        .transition(
            .scale.combined(with: .opacity)
        )
    }
}

struct MatchDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        //        MatchDetailsView()
        ProgressView()
    }
}

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
                Text("\(match.matchType) \(match.numberOfGames)"
                    .replacingOccurrences(of: "_", with: " ")
                    .capitalized
                )
                Text(match.league.name)
                Text(match.scheduledAt)
                if match.status == GameStatus.running.rawValue,
                   let liveEmbedUrl = match.liveEmbedUrl,
                   let url = URL(string: liveEmbedUrl) {
                    Link(destination: url) {
                        Text("Watch online")
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

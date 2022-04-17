//
//  MatchView.swift
//  ESportsHub
//
//  Created by Константин Чернов on 15.03.2022.
//

import SwiftUI

struct MatchView: View {
    @ObservedObject var viewModel: MatchesViewModel
    var match: DotaMatchModel
    @State var clicked = false
    
    var body: some View {
        VStack {
            HStack {
                if let firstOpp = match.opponents.first?.opponent,
                   let secondOpp = match.opponents.last?.opponent {
                    Spacer()
                    teamImageView(imageID: firstOpp.id)
                    Text(match.name)
                        .lineLimit(1)
                    teamImageView(imageID: secondOpp.id)
                    Spacer()
                }
            }
            if clicked {
                VStack {
                    Text("\(match.matchType) \(match.numberOfGames)"
                            .replacingOccurrences(of: "_", with: " ")
                            .capitalized
                    )
                    Text(match.league.name)
                    Text(match.scheduledAt)
                }
                .transition(AnyTransition.asymmetric(
                    insertion: .move(edge: .top).combined(with: .opacity),
                    removal: .scale.combined(with: .opacity)
                ))
            }
        }
        .onTapGesture {
            withAnimation(.easeInOut(duration: 0.5)) {
                clicked.toggle()
            }
        }
    }
    
    func teamImageView(imageID: Int?) -> some View {
        if let index = imageID,
           let image = viewModel.cachedImages[index] {
            return Image(uiImage: image)
                .resizable()
                .frame(width: 30, height: 30)
        }
        return Image("dota")
            .resizable()
            .frame(width: 30, height: 30)
    }
}

struct MatchView_Previews: PreviewProvider {
    static var previews: some View {
        //        MatchView()
        ProgressView()
    }
}

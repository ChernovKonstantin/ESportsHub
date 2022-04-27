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
                    if match.status == GameStatus.running.rawValue {
                        showLiveImage()
                    }
                    teamImageView(imageID: firstOpp.id)
                    Text((firstOpp.acronym ?? firstOpp.name) + " vs " + (secondOpp.acronym ?? secondOpp.name))
                        .lineLimit(1)
                    teamImageView(imageID: secondOpp.id)
                    Spacer()
                }
            }
            if clicked {
                MatchDetailsView(match: match)
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
    
    func showLiveImage() -> some View {
        Circle()
            .fill(Color.red)
            .frame(width: 10, height: 10)
    }
}

struct MatchView_Previews: PreviewProvider {
    static var previews: some View {
        //        MatchView()
        ProgressView()
    }
}

//
//  TournamentsView.swift
//  ESportsHub
//
//  Created by Константин Чернов on 09.05.2022.
//

import SwiftUI

struct TournamentsView: View {
    @ObservedObject var viewModel = TournamentsViewModel()
    
    var body: some View {
        NavigationView {
            VStack {
                Picker("", selection: $viewModel.pickedMatchesStatus) {
                    ForEach(RequestFilterStatus.allCases, id: \.self) {
                        Text($0.stringValue)
                    }
                }
                .pickerStyle(.segmented)
                .padding()
                ScrollView {
                    ForEach (viewModel.tournaments) { tournament in
                        VStack {
                            Text(tournament.name)
                            Text(tournament.league.name)
                            Text(tournament.serie.fullName)
                            Divider()
                        }
                    }
                }
                .navigationTitle("Tournaments")
                .task {
                    await viewModel.fetchTournaments()
                }
            }
        }
    }
}

struct TournamentsView_Previews: PreviewProvider {
    static var previews: some View {
        TournamentsView()
    }
}

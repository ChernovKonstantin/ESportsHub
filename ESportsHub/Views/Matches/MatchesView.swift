//
//  MatchesView.swift
//  ESportsHub
//
//  Created by Константин Чернов on 23.02.2022.
//

import SwiftUI

struct MatchesView: View {
    @StateObject var viewModel = MatchesViewModel()
    
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
                    ForEach(viewModel.matches) { match in
                        VStack {
                            MatchView(viewModel: viewModel, match: match)
                            Divider()
                        }
                        .task {
                            await viewModel.fetchImage(for: match.opponents)
                            
                            //                        if viewModel.repositories.last == repo,
                            //                           viewModel.canLoadMore {
                            //                            if searchText.isEmpty {
                            //                                await viewModel.fetchRepos()
                            //                            } else {
                            //                                await viewModel.fetchRepos(withName: searchText)
                            //                            }
                            //                        }
                        }
                    }
                }
                .navigationTitle("Matches")
                .task {
                    await viewModel.fetchMatches() 
                }
            }
        }
    }
}

struct MatchesView_Previews: PreviewProvider {
    static var previews: some View {
        MatchesView()
    }
}

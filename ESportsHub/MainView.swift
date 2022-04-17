//
//  MainView.swift
//  GitSearchSwiftUI
//
//  Created by Константин Чернов on 23.02.2022.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            MatchesView()
                .tag(AppBottomNavigationTab.matches.rawValue)
                .tabItem {
                    Label("Matches", systemImage: "calendar")
                }
            MatchesView()
                .tag(AppBottomNavigationTab.tournaments.rawValue)
                .tabItem {
                    Label("Tournaments", systemImage: "flag.fill")
                }
            MatchesView()
                .tag(AppBottomNavigationTab.teams.rawValue)
                .tabItem {
                    Label("Teams", systemImage: "person.3.fill")
                }
            MatchesView()
                .tag(AppBottomNavigationTab.players.rawValue)
                .tabItem {
                    Label("Players", systemImage: "person.text.rectangle.fill")
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

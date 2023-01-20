//
//  MatchesFilter.swift
//  ESportsHub
//
//  Created by Константин Чернов on 27.04.2022.
//

import Foundation

enum RequestFilterStatus: CaseIterable {
    
    case upcoming
    case running
    case past
    
    var stringValue: String {
        switch self {
        case .running:
            return "Running"
        case .past:
            return "Past"
        case .upcoming:
            return "Upcoming"
        }
    }
}

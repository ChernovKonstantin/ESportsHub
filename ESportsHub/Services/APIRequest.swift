//
//  APIRequest.swift
//  ESportsHub
//
//  Created by Константин Чернов on 23.02.2022.
//

import Foundation

enum APIRequest {
    
    case upcomingMatches
    case tournaments
    case teams
    case players
    case runningMatches
    case pastMatches
    
    func asURLRequest(url: String = "", perPage: Int = 30, page: Int = 1) -> URLRequest {
        var params = ["sort": "begin_at", "page": "\(page)", "per_page": "\(perPage)"]
        switch self {
        case .pastMatches:
            params["sort"] = "-scheduled_at"
            return buildRequest(urlString: "\(APICreds.baseURl)/matches/past", parameters: params)
        case .runningMatches:
            return buildRequest(urlString: "\(APICreds.baseURl)/matches/running", parameters: params)
        case .upcomingMatches:
            return buildRequest(urlString: "\(APICreds.baseURl)/matches/upcoming", parameters: params)
        case .players:
            return buildRequest(urlString: "\(APICreds.baseURl)/players", parameters: params)
        case .teams:
            return buildRequest(urlString: "\(APICreds.baseURl)/teams", parameters: params)
        case .tournaments:
            return buildRequest(urlString: "\(APICreds.baseURl)/matches", parameters: params)
        }
    }
    
    private func buildRequest(urlString: String, parameters: [String:String]? = nil) -> URLRequest {
        
        let headers = [
            "Accept": "application/json",
            "Authorization": APICreds.authToken
        ]
        
        var urlWithParameters = urlString
        if parameters?.isEmpty == false {
            urlWithParameters += "?"
            parameters?.forEach { name, value in
                urlWithParameters += "\(name)=\(value)&"
            }
        }
        
        var request = URLRequest(url: URL(string: urlWithParameters)!,
                                 cachePolicy: .useProtocolCachePolicy,
                                 timeoutInterval: 10)
        
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        return request
        
    }
}

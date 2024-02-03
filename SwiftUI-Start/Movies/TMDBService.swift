//
//  TMDBService.swift
//  SwiftUI-Start
//
//  Created by 최최광현 on 1/5/24.
//

import Foundation
import Moya

enum TMDBService {
    case nowPlaying(Int)
    case popular(Int)
    case topRated(Int)
    case upcoming(Int)
}

extension TMDBService: TargetType {
    var baseURL: URL {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie") else {
            fatalError()
        }
        return url
    }
    
    var path: String {
        switch self {
        case .nowPlaying:
            "/now_playing"
        case .popular:
            "/popular"
        case .topRated:
            "/top_rated"
        case .upcoming:
            "/upcoming"
        }
    }
    
    var method: Moya.Method {
        .get
    }
    
    var task: Moya.Task {
        switch self {
        case let .nowPlaying(page):
            return .requestParameters(parameters: ["language": "ko-KR", "page": page], encoding: URLEncoding.queryString)
        case let .popular(page):
            return .requestParameters(parameters: ["language": "ko-KR", "page": page], encoding: URLEncoding.queryString)
        case let .topRated(page):
            return .requestParameters(parameters: ["language": "ko-KR", "page": page], encoding: URLEncoding.queryString)
        case let .upcoming(page):
            return .requestParameters(parameters: ["language": "ko-KR", "page": page], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        [
            "Authorization" : "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJmZmE3NGM2NmE4MTViYTI3NzAzNjdmMTc1ZTgxODhlOSIsInN1YiI6IjY0M2JhYTFjNzE5YWViMDRjYmViZWVkOSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.3XqlRAnhTm9oIAPb_4zT8dWLyySVIfOl-mA8UZqgrzg",
            "accept" : "applcation/json"
        ]
    }
    
    
}

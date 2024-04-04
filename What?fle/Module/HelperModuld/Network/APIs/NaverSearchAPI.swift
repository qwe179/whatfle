//
//  NetworkService.swift
//  What?fle
//
//  Created by 이정환 on 2/28/24.
//

import Foundation
import Moya


enum NaverSearchAPI {
    case search(query: String)
}

extension NaverSearchAPI: TargetType {
    var method: Moya.Method {
        switch self {
        case .search:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .search(let query):
            let parameters: [String : Any] = [
                "query" : query,
                "display" : 5,
                "sort" : "random"
            ]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return [
            "X-Naver-Client-Id": AppConfigs.API.Key.Naver.clientID,
            "X-Naver-Client-Secret": AppConfigs.API.Key.Naver.clientSecret,
            "Accept": "*/*"
        ]
    }
    
    
    var baseURL: URL {
        return URL(string: AppConfigs.API.URL.Naver.search)!
    }
    
    var path: String {
        switch self {
        case .search(let query):
            return "/query/\(query)"
        }
    }
}

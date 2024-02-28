//
//  KakaoSearchAPI.swift
//  What?fle
//
//  Created by 이정환 on 2/29/24.
//

import Foundation
import Moya

enum KakaoSearchAPI {
    case search(_ query: String, _ page: Int)
}

extension KakaoSearchAPI: TargetType {
    var method: Moya.Method {
        switch self {
        case .search:
            return .get
        }
    }

    var task: Moya.Task {
        switch self {
        case .search(let query, let page):
            let parameters: [String: Any] = [
                "query": query,
                "page": page
            ]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        }
    }

    var headers: [String: String]? {
        return [
            "Authorization": "KakaoAK \(AppConfigs.API.Key.Kakao.kakaoRESTAPIKey)"
        ]
    }

    var baseURL: URL {
        return URL(string: AppConfigs.API.URL.Kakao.search)!
    }

    var path: String {
        switch self {
        case .search:
            return "search/keyword"
        }
    }
}

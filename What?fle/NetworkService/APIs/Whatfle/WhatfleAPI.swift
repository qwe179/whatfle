//
//  WhatfleAPI.swift
//  What?fle
//
//  Created by 이정환 on 4/6/24.
//

import Foundation
import Moya

enum WhatfleAPI {
    case retriveRegistLocation
}

extension WhatfleAPI: TargetType {
    var method: Moya.Method {
        switch self {
        default: .get
        }
    }

    var task: Moya.Task {
        switch self {
        case .retriveRegistLocation:
            let parameters: [String: Any] = [:]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        }
    }

    var headers: [String: String]? {
        return [
            "Authorization": ""
        ]
    }

    var baseURL: URL {
        return URL(string: AppConfigs.API.URL.Kakao.search)!
    }

    var path: String {
        switch self {
        default: ""
        }
    }

    var sampleData: Data {
        switch self {
        case .retriveRegistLocation:
            guard let path = Bundle.main.path(forResource: "RetriveRegistLocationMock", ofType: "json"),
                  let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
                return Data()
            }
            return data
        }
    }
}

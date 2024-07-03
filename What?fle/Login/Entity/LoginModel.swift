//
//  LoginModel.swift
//  What?fle
//
//  Created by 23 09 on 7/3/24.
//

import Foundation

// MARK: - LoginModel
struct LoginModel: Codable {
    let id: Int
    let thirdPartyAuthType, thirdPartyAuthUid: String
    let nickname, profileImagePath: JSONNull?
    let email, createdAt: String
    let updatedAt, deletedAt: JSONNull?
    let isAgreement: Bool
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
            return true
    }

    public var hashValue: Int {
            return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            if !container.decodeNil() {
                    throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
            }
    }

    public func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            try container.encodeNil()
    }
}

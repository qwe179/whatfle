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
    let thirdPartyAuthType: String
    let thirdPartyAuthUid: String
    let nickname: String?
    let profileImagePath: String?
    let email: String?
    let createdAt: String
    let updatedAt: String?
    let deletedAt: String?
    let isAgreement: Bool
}

// MARK: - Encode/decode helpers

struct JSONNull: Codable, Hashable {
    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(0)
    }

    public init() {}

    public init(from decoder: Decoder) throws {
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

//
//  ResponseDto.swift
//  SnappChallenge
//
//  Created by Mohammad Reza Sohrabi on 2024-05-01.
//

import Foundation

struct LaunchResponseDto: Decodable {
    let totalDocs: Int
    let offset: Int
    let limit: Int
    let totalPages: Int
    let page: Int
    let pagingCounter: Int
    let hasPrevPage: Bool
    let hasNextPage: Bool
    let prevPage: Int?
    let nextPage: Int?
    let docs: [doc]

    struct doc: Decodable {
        let links: Links?
        let success: Bool?
        let failures: [Failure]?
        let details: String?
        let flightNumber: Int
        let name: String?
        let dateUTC: String?

        struct Links: Decodable {
            let patch: Patch?
            let wikipedia: String?

            struct Patch: Decodable {
                let small: String?
                let large: String?
            }
        }

        struct Failure: Decodable {
            let reason: String?
        }

        enum CodingKeys: String, CodingKey {
            case links
            case success
            case failures
            case details
            case flightNumber = "flight_number"
            case name
            case dateUTC = "date_utc"
        }
    }
}

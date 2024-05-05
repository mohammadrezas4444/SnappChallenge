//
//  QueryParamsDto.swift
//  SnappChallenge
//
//  Created by Mohammad Reza Sohrabi on 2024-05-05.
//

import Foundation

struct QueryParams: Encodable {
    let query: Query
    let options: Options

    struct Query: Encodable {
        let upcoming: Bool
    }

    struct Options: Encodable {
        let limit: Int
        let page: Int

        struct Sort: Encodable {
            let flight_number: String
        }
    }
}

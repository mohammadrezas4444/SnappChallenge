//
//  DomainModel.swift
//  SnappChallenge
//
//  Created by Mohammad Reza Sohrabi on 2024-05-02.
//

import Foundation

struct LaunchesModel {
    var isBookmarked: Bool = false
    let links: Links?
    let success: Bool?
    let failures: [Failure]?
    let details: String?
    let flightNumber: Int
    let name: String?
    let dateUTC: String?

    struct Links {
        let patch: Patch?
        let wikipedia: String?

        struct Patch {
            let small: String?
            let large: String?
        }
    }

    struct Failure {
        let reason: String?
    }
}

struct LaunchesSections: Hashable {
    struct Section: Hashable {
        let items: [Item]

        enum Item: Hashable {
            case allLaunches(LaunchesModel)
        }
    }
}

extension LaunchesSections.Section.Item {
    static func == (lhs: LaunchesSections.Section.Item, rhs: LaunchesSections.Section.Item) -> Bool {
        switch (lhs, rhs) {
        case (.allLaunches(let lhsLaunches), .allLaunches(let rhsLaunches)):
            return lhsLaunches.flightNumber == rhsLaunches.flightNumber &&
            lhsLaunches.success == rhsLaunches.success &&
            lhsLaunches.name == rhsLaunches.name &&
            lhsLaunches.dateUTC == rhsLaunches.dateUTC
        }
    }

    func hash(into hasher: inout Hasher) {
        switch self {
        case .allLaunches(let launchesModel):
            hasher.combine(launchesModel.flightNumber)
        }
    }
}

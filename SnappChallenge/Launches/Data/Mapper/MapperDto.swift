//
//  MapperDto.swift
//  SnappChallenge
//
//  Created by Mohammad Reza Sohrabi on 2024-05-02.
//

import Foundation

extension LaunchResponseDto.doc {
    func mapToModel() -> LaunchesModel {
        return LaunchesModel(
            links: .init(
                patch: .init(
                    small: self.links?.patch?.small,
                    large: self.links?.patch?.large),
                wikipedia: self.links?.wikipedia),
            success: self.success,
            failures: self.failures?.compactMap {
                LaunchesModel.Failure(reason: $0.reason) },
            details: self.details,
            flightNumber: self.flightNumber,
            name: self.name,
            dateUTC: self.dateUTC
        )
    }
}

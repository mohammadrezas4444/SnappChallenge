//
//  MapperDto.swift
//  SnappChallenge
//
//  Created by Mohammad Reza Sohrabi on 2024-05-02.
//

import Foundation

extension LaunchResponseDto {
    func mapToModel() -> LaunchesModel {
        return LaunchesModel(
            totalDocs: self.totalDocs,
            offset: self.offset,
            limit: self.limit,
            totalPages: self.totalPages,
            page: self.page,
            pagingCounter: self.pagingCounter,
            hasPrevPage: self.hasPrevPage,
            hasNextPage: self.hasNextPage,
            prevPage: self.prevPage,
            nextPage: self.nextPage,
            docs: self.docs.compactMap { $0.mapToDocModel() }
        )
    }
}

extension LaunchResponseDto.doc {
    func mapToDocModel() -> LaunchesModel.doc {
        return LaunchesModel.doc(
            links: .init(
                patch: .init(
                    small: self.links?.patch?.small,
                    large: self.links?.patch?.large),
                wikipedia: self.links?.wikipedia),
            success: self.success,
            failures: self.failures?.compactMap {
                LaunchesModel.doc.Failure(reason: $0.reason) },
            details: self.details,
            flightNumber: self.flightNumber,
            name: self.name,
            dateUTC: self.dateUTC
        )
    }
}

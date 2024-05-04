//
//  NetworkServiceError.swift
//  SnappChallenge
//
//  Created by Mohammad Reza Sohrabi on 2024-05-01.
//

import Foundation

enum NetworkServiceError: Error {
    case badUrl, requestError, decodingError, statusNotOK, noInternet
}

//
//  Error.swift
//  Woods-JWA
//
//  Created by Johannes Ahlborn on 10.01.24.
//

import Foundation
enum HTTPError : Error {
    case invalidURL
    case missingData
    case invalidResponse
}

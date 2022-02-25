//
//  DGErrors.swift
//  DesafioDigio
//
//  Created by Everton Carneiro on 25/02/22.
//

import Foundation

enum DGErrors: Error, LocalizedError {
    case requestFail
    case decodeFail
    case unknown
    
    var errorDescription: String? {
        switch self {
        case .requestFail:
            return NSLocalizedString("Something went wrong with the request", comment: "Bad request")
        case .decodeFail:
            return NSLocalizedString("Parsing error: Fail to decode", comment: "Fail to decode")
        case .unknown:
            return NSLocalizedString("An unknown error ocurred", comment: "Unknown error")
        }
    }
}

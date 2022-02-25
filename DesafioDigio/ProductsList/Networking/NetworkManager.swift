//
//  NetworkManager.swift
//  DesafioDigio
//
//  Created by Everton Carneiro on 25/02/22.
//

import Foundation

public class NetworkManager {
    enum NetworkResponse: Error {
        case success
        case forbidden
        case badRequest
        case outdated
        case failed
        case notFound
        case unableToDecode
    }
    
    func handleNetworkResponse(_ response: HTTPURLResponse) -> Result<NetworkResponse, Error> {
        switch response.statusCode {
        case 200...299: return .success(NetworkResponse.success)
        case 401...403: return .failure(NetworkResponse.forbidden)
        case 404: return .failure(NetworkResponse.notFound)
        case 405...499: return .failure(NetworkResponse.failed)
        case 500...599: return .failure(NetworkResponse.badRequest)
        case 600: return .failure(NetworkResponse.outdated)
        default: return .failure(NetworkResponse.unableToDecode)
        }
    }
}

//
//  URLs.swift
//  DesafioDigio
//
//  Created by Everton Carneiro on 25/02/22.
//

import Foundation

struct ApiURL {
    static func urlBuilder(endPoint: EndPoint) -> URL? {
        var components = URLComponents()
         components.scheme = "https"
         components.host = "7hgi9vtkdc.execute-api.sa-east-1.amazonaws.com"
         components.path = endPoint.path
         return components.url
    }
}

enum EndPoint {
    case products
    case mock404
    
    var path: String {
        switch self {
        case .products:
            return "/sandbox/products"
        case .mock404:
            return "/mock404"
        }
    }
}


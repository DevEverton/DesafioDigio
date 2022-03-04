//
//  MockProductsService.swift
//  DesafioDigio
//
//  Created by Everton Carneiro on 03/03/22.
//

import Foundation

class MockProductsService: ProductsServiceProtocol {
    
    var fetchProductsCalled = false
    
    func fetch(completion: @escaping ResultHandler) {
        fetchProductsCalled = true
        completion(.success(AllProducts(spotlight: [], products: [], cash: .init(title: "", bannerURL: "", description: ""))))
    }

}

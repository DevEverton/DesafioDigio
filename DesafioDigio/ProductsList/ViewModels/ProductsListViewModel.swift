//
//  ProductsListViewModel.swift
//  DesafioDigio
//
//  Created by Everton Carneiro on 27/02/22.
//

import Foundation

class ProductsListViewModel {
    
    let service: ProductsServiceProtocol
    private(set) var spotlightProducts = [SpotLightProduct]()
    private(set) var products = [Product]()
    private(set) var cash = Cash(title: "", bannerURL: "", description: "")
    let title = "Olá, Everton"
    
    init(service: ProductsServiceProtocol = ProductsService()) {
        self.service = service
    }
    
    func loadProducts(_ completion: @escaping (Result<Void, DGErrors>) -> Void) {
        service.fetch { result in
            switch result {
            case .success(let products):
                self.spotlightProducts = products.spotlight
                self.products = products.products
                self.cash = products.cash
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

}

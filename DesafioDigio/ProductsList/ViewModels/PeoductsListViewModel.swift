//
//  PeoductsListViewModel.swift
//  DesafioDigio
//
//  Created by Everton Carneiro on 27/02/22.
//

import Foundation

class PeoductsListViewModel {
    
    let service: ProductsServiceProtocol
    private(set) var allProducts: AllProducts? = nil
    let title = "Olá, Everton"
    
    init(service: ProductsServiceProtocol = ProductsService()) {
        self.service = service
    }
    
    func loadProducts(_ completion: @escaping (Result<Void, DGErrors>) -> Void) {
        service.fetch { result in
            switch result {
            case .success(let products):
                self.allProducts = products
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

}

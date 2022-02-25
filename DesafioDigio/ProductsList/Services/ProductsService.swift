//
//  ProductsService.swift
//  DesafioDigio
//
//  Created by Everton Carneiro on 25/02/22.
//

import Foundation

typealias ResultHandler = (Result<AllProducts, DGErrors>) -> Void

public protocol Service { }

extension Service {
    public var manager: NetworkManager { return NetworkManager() }
}

protocol ProductsServiceProtocol: Service {
    func fetch(completion: @escaping ResultHandler)
}


class ProductsService: ProductsServiceProtocol {
    func fetch(completion: @escaping ResultHandler) {
       
        let apiURL = ApiURL.urlBuilder(endPoint: .products)

        guard let api = apiURL else {
            completion(.failure(.requestFail))
            return
        }
        
        let session = URLSession.shared
        let task = session.dataTask(with: api) { (data, response, error) in
            guard let jsonData = data else {
                completion(.failure(.requestFail))
                return
            }
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(.requestFail))
                return
            }
            
            let result = self.manager.handleNetworkResponse(response)
            
            switch result {
            case .success:
                do {
                    let decoder = JSONDecoder()
                    let decoded = try decoder.decode(AllProducts.self, from: jsonData)
                    DispatchQueue.main.async {
                        completion(.success(decoded))
                    }
                } catch {
                    completion(.failure(.decodeFail))
                }
            case .failure:
                completion(.failure(.unknown))
            }
        }
        
        task.resume()
    }

}

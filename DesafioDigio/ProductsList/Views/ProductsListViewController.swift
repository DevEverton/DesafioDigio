//
//  ProductsListViewController.swift
//  DesafioDigio
//
//  Created by Everton Carneiro on 25/02/22.
//

import UIKit

class ProductsListViewController: UIViewController {
    var service: ProductsService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        service = ProductsService()
        service.fetch { result in
            print("Fetch result: \(result)")
        }
    }
}


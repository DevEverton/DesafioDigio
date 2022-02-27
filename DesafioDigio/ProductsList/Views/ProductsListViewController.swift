//
//  ProductsListViewController.swift
//  DesafioDigio
//
//  Created by Everton Carneiro on 25/02/22.
//

import UIKit

class ProductsListViewController: UIViewController {
    var viewModel: PeoductsListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = PeoductsListViewModel()
        viewModel.loadProducts { result in
            print("loaded list: \(self.viewModel.allProducts)")
        }
    }
}


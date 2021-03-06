//
//  ProductsListViewController.swift
//  DesafioDigio
//
//  Created by Everton Carneiro on 25/02/22.
//

import UIKit

class ProductsListViewController: UIViewController, NavigationControllerInjected {
    
    var spotLightScroller = SpotlightScrollerComponent()
    var cashSection = CashSectionComponent()
    var productsScroller = ProductsScrollerComponent()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        scrollView.backgroundColor = .white
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    lazy var mainStack: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.distribution = .fill
        stackview.spacing = 24
        stackview.translatesAutoresizingMaskIntoConstraints = false
        return stackview
    }()
    
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = viewModel.title
        label.numberOfLines = 0
        label.sizeToFit()
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let productsTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "digioBlue")!
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.text = "Produtos"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var activity: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView()
        activity.hidesWhenStopped = true
        activity.translatesAutoresizingMaskIntoConstraints = false
        activity.startAnimating()
        return activity
    }()
    
    
    var viewModel: ProductsListViewModel!

    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white
        navigationItem.backButtonTitle = "Produtos"
        navigationController?.navigationBar.tintColor = .black

        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ProductsListViewModel()
                
        loadData()
        setupViews()
    }

    func loadData() {
        viewModel.loadProducts { [weak self] (result) in
            guard let self = self else { return }
            self.activity.stopAnimating()

            DispatchQueue.main.async {
                switch result {
                case .success:
                    self.spotLightScroller.model = .init(products: self.viewModel.spotlightProducts)
                    
                    self.cashSection.model = .init(title: self.viewModel.cash.title, bannerImageUrl: self.viewModel.cash.bannerURL)
                    
                    self.productsScroller.model = .init(products: self.viewModel.products)
                    
                case .failure(let error):
                    let alert = UIAlertController(title: "Ops, ocorreu um erro", message: error.localizedDescription, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true)
                }
            }
        }
    }
    
    func setupViews() {
        setupScrollView()
        setupRouterForCashSection()
    }
    
    func setupRouterForCashSection() {
        let cashSectionGesture = UITapGestureRecognizer(target: self, action: #selector(handleCashSectionTap))
        cashSection.addGestureRecognizer(cashSectionGesture)
        cashSection.isUserInteractionEnabled = true
    }
    
    func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(mainStack)
        
        scrollView.addSubview(activity)
        
        [titleLabel,
         spotLightScroller,
         cashSection,
         productsTitleLabel,
         productsScroller].forEach { mainStack.addArrangedSubview($0) }
        
        cashSection.translatesAutoresizingMaskIntoConstraints = false
        productsScroller.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activity.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            activity.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
            cashSection.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16)
        ])
        
        mainStack.setCustomSpacing(40, after: titleLabel)

        scrollView.pinToEdges(of: view)
        mainStack.pinToEdges(of: scrollView, withSpacing: 16)
    }
    
    @objc func handleCashSectionTap(_ sender: UITapGestureRecognizer) {
        let vc = DetailViewController()
        vc.model = .init(title: viewModel.cash.title, bannerImage: cashSection.bannerImageView.image, description: viewModel.cash.description)
        navController.pushViewController(vc, animated: true)
    }
    
}



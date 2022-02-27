//
//  ProductsListViewController.swift
//  DesafioDigio
//
//  Created by Everton Carneiro on 25/02/22.
//

import UIKit

class ProductsListViewController: UIViewController {
    
    var cashSection = CashSectionComponent()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = viewModel.title
        label.numberOfLines = 0
        label.sizeToFit()
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
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
    
    
    var viewModel: PeoductsListViewModel!

    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white
        
        self.view = view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = PeoductsListViewModel()
                
        setupViews()
        loadData()
    }
    
    func loadData() {
        viewModel.loadProducts { [weak self] (result) in
            guard let self = self else { return }
            self.activity.stopAnimating()

            DispatchQueue.main.async {
                switch result {
                case .success:
                    

                    if let imageUrl = URL(string: self.viewModel.cash.bannerURL) {
                        DispatchQueue.global(qos: .background).async {
                            if let data = try? Data(contentsOf: imageUrl) {
                                if let image = UIImage(data: data) {
                                    DispatchQueue.main.async {
                                        self.cashSection.model = .init(title: self.viewModel.cash.title, bannerImage: image)
                                    }
                                }
                            }
                        }
                    }
                    
                case .failure(let error):
                    let alert = UIAlertController(title: "Ops, ocorreu um erro", message: error.localizedDescription, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true)
                }
            }
            
        }
    }
    
    private func loadImage(imageUrl: String) -> UIImage {
        guard let imageURL = URL(string: imageUrl) else { return UIImage() }
        var resultImage = UIImage()

        DispatchQueue.global(qos: .background).async {
            if let data = try? Data(contentsOf: imageURL) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        resultImage = image
                    }
                }
            }
        }
        return resultImage
    }
    
    func setupViews() {
        setupScrollView()
        setupCashSection()
    }
    
    func setupCashSection() {
        NSLayoutConstraint.activate([
            cashSection.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16)
        ])
    }
    
    func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(activity)
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(cashSection)
        
        cashSection.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activity.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            activity.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
            titleLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            cashSection.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            cashSection.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            cashSection.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16)
        ])
        scrollView.pinToEdges(of: view)
    }
    
}


extension UIScrollView {
    func pinToEdges(of view: UIView) {
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: view.topAnchor),
            self.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            self.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            self.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            self.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
    }
}

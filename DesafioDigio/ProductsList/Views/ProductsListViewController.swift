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
        let scrollView = UIScrollView(frame: .init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        scrollView.backgroundColor = .white
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    lazy var mainStack: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.distribution = .fill
        stackview.spacing = 12
        stackview.translatesAutoresizingMaskIntoConstraints = false
        return stackview
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
                    self.cashSection.model = .init(title: self.viewModel.cash.title, bannerImageUrl: self.viewModel.cash.bannerURL)
                    
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
        setupCashSection()
    }
    
    func setupCashSection() {
        NSLayoutConstraint.activate([
            cashSection.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16)
        ])
    }
    
    func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(mainStack)
        
        scrollView.addSubview(activity)
        mainStack.addSubview(titleLabel)
        mainStack.addSubview(cashSection)
        
        cashSection.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activity.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            activity.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
            titleLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            cashSection.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            cashSection.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            cashSection.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor)
        ])
        scrollView.pinToEdges(of: view)
        mainStack.pinToEdges(of: scrollView)
    }
    
    func setUpScrollViewContentSize() {
        let contentRect: CGRect = scrollView.subviews.reduce(into: .zero) { rect, view in
            rect = rect.union(view.frame)
        }
        scrollView.contentSize = contentRect.size
    }
    
}

extension UIView {
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

extension UIImageView {
    
    func setImage(withURL urlString: String, placeholderImage: UIImage) {
        image = placeholderImage
        
        let url = URL.init(string: urlString)
        let request = URLRequest.init(url: url!)
        let session = URLSession.shared

        let datatask = session.dataTask(with: request) { (data, response, error) in
            if let imgData = data {
                DispatchQueue.main.async { [weak self] in
                    self?.image = UIImage.init(data: imgData)
                }
            }
            
        }
        datatask.resume()
    }
}

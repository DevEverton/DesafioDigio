//
//  ProductsScrollerComponent.swift
//  DesafioDigio
//
//  Created by Everton Carneiro on 27/02/22.
//

import UIKit

class ProductsScrollerComponent: UIView {
    typealias Model = CashSectionModel
    
    var model: Model? {
        didSet {
            bind()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.addSubview(stackView)
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    struct CashSectionModel {
        let products: [Product]
    }
    
    private func setupView() {
        self.addSubview(scrollView)
        scrollView.pinToEdges(of: self)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -32),
            stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            
        ])
        
    }
    
    func bind() {
        guard let model = model else { return }
        for product in model.products {
            stackView.addArrangedSubview(createBannerImage(withUrl: product.imageURL))
        }
    }
    
    private func createBannerImage(withUrl url: String) -> UIView {
        let containerView = UIView()
        let imageView = UIImageView()
        containerView.addSubview(imageView)
       
        containerView.backgroundColor = .systemGray5
        imageView.contentMode = .scaleAspectFit
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.heightAnchor.constraint(equalToConstant: 120),
            containerView.widthAnchor.constraint(equalToConstant: 120),
            imageView.heightAnchor.constraint(equalToConstant: 60),
            imageView.widthAnchor.constraint(equalToConstant: 60),
            imageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
        
        imageView.setImage(withURL: url, placeholderImage: UIImage())
        containerView.layer.cornerRadius = 12
        containerView.clipsToBounds = true
        
        return containerView
    }
}


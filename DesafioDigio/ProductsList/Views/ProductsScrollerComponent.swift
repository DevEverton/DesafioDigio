//
//  ProductsScrollerComponent.swift
//  DesafioDigio
//
//  Created by Everton Carneiro on 27/02/22.
//

import UIKit

class ProductsScrollerComponent: UIView, NavigationControllerInjected {
    typealias Model = CashSectionModel
    
    private var logos = [UIView]()
    private var products = [Product]()
    
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
        addSubview(scrollView)
        scrollView.pinToEdges(of: self)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 8),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -32),
            stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor),
            
        ])
        
    }
    
    func bind() {
        guard let model = model else { return }
        var view = UIView()
        
        for product in model.products {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
            view = createBannerImage(withUrl: product.imageURL)
            view.addGestureRecognizer(tapGesture)
            stackView.addArrangedSubview(view)
            logos.append(view)
            products.append(product)
        }
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {

        let vc = ProductDetail()
        var product = Product(name: "", imageURL: "", description: "")
        
        for index in 0..<logos.count {
            if logos[index] == sender.view {
                product = products[index]
            }
        }
        vc.model = .init(title: product.name, logo: createBannerImage(withUrl: product.imageURL), description: product.description)
        navController.pushViewController(vc, animated: true)
    }
    
    private func createBannerImage(withUrl url: String) -> UIView {
        let containerView = UIView()
        let imageView = UIImageView()
        addSubview(containerView)
        containerView.addSubview(imageView)
       
        containerView.backgroundColor = .white
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.heightAnchor.constraint(equalToConstant: 120),
            containerView.widthAnchor.constraint(equalToConstant: 120),
            containerView.topAnchor.constraint(equalTo: stackView.topAnchor, constant: 5),
            containerView.bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: -5),
            imageView.heightAnchor.constraint(equalToConstant: 60),
            imageView.widthAnchor.constraint(equalToConstant: 60),
            imageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
        
        imageView.setImage(withURL: url, placeholderImage: UIImage())
        imageView.contentMode = .scaleAspectFit
        containerView.layer.cornerRadius = 12
        
        containerView.addShadowWithRoundedCorners(of: 12)
        containerView.isUserInteractionEnabled = true
        
        return containerView
    }
    
}

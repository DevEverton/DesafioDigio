//
//  SpotlightScrollerComponent.swift
//  DesafioDigio
//
//  Created by Everton Carneiro on 27/02/22.
//

import UIKit

class SpotlightScrollerComponent: UIView {
    typealias Model = CashSectionModel
    
    private var banners = [UIImageView]()
    private var products = [SpotLightProduct]()
    
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
        let products: [SpotLightProduct]
    }
    
    private func setupView() {
        addSubview(scrollView)
        scrollView.pinToEdges(of: self)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -32),
            stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        ])
        
    }
    
    func bind() {
        guard let model = model else { return }
        var imageView = UIImageView()
        
        for product in model.products {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
            imageView = createBannerImage(withUrl: product.bannerURL)
            imageView.addGestureRecognizer(tapGesture)
            stackView.addArrangedSubview(imageView)
            banners.append(imageView)
            products.append(product)
        }
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {

        let vc = DetailViewController()
        var product = SpotLightProduct(name: "", bannerURL: "", description: "")
        var banner = UIImageView()
        
        for index in 0..<banners.count {
            if banners[index] == sender.view {
                product = products[index]
                banner = banners[index]
            }
        }
        vc.model = .init(title: product.name, bannerImage: banner.image, description: product.description)
        NavigationController.shared.pushViewController(vc, animated: true)
    }
    
    func getDataForDetailView(product: SpotLightProduct) -> SpotLightProduct {
        product
    }
    
    private func createBannerImage(withUrl url: String) -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 200),
            imageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 32),
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)
        ])
        imageView.setImage(withURL: url, placeholderImage: UIImage())
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true

        return imageView
    }
    
}

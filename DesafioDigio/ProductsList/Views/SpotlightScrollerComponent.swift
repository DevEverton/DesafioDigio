//
//  SpotlightScrollerComponent.swift
//  DesafioDigio
//
//  Created by Everton Carneiro on 27/02/22.
//

import UIKit

class SpotlightScrollerComponent: UIView {
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
        let products: [SpotLightProduct]
    }
    
    private func setupView() {
        self.addSubview(scrollView)
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
        for product in model.products {
            stackView.addArrangedSubview(createBannerImage(withUrl: product.bannerURL))
        }
    }
    
    private func createBannerImage(withUrl url: String) -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 12
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalToConstant: 200),
            imageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 32)
        ])
        imageView.clipsToBounds = true
        imageView.setImage(withURL: url, placeholderImage: UIImage())
        return imageView
    }
    
}

//
//  CashSectionComponent.swift
//  DesafioDigio
//
//  Created by Everton Carneiro on 27/02/22.
//

import UIKit

class CashSectionComponent: UIView {
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
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let bannerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 12
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        imageView.clipsToBounds = true
        return imageView
    }()
    
    
    let stack: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.distribution = .fill
        stackview.spacing = 8
        stackview.translatesAutoresizingMaskIntoConstraints = false
        return stackview
    }()
    
    struct CashSectionModel {
        let title: String
        let bannerImageUrl: String
    }
    
    private func setupView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(stack)
        [titleLabel,bannerImageView].forEach { stack.addArrangedSubview($0) }
        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    func bind() {
        guard let model = model else { return }
        titleLabel.attributedText = setupMutableString(title: model.title)
        bannerImageView.setImage(withURL: model.bannerImageUrl, placeholderImage: UIImage())
    }
    
    private func setupMutableString(title: String) -> NSMutableAttributedString {
        let mutableString = NSMutableAttributedString(string: title, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 20, weight: .bold)])
        mutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(named: "digioBlue")!, range: NSRange(location: 0, length:5))
        return mutableString
    }
}

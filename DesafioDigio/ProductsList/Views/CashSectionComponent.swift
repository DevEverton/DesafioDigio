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
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var bannerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 12
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    lazy var stack: UIStackView = {
        let stackview = UIStackView()
        stackview.backgroundColor = .red
        stackview.axis = .vertical
        stackview.distribution = .fill
        stackview.spacing = 12
        stackview.translatesAutoresizingMaskIntoConstraints = false
        return stackview
    }()
    
    struct CashSectionModel {
        let title: String
        let bannerImage: UIImage
    }
    
    private func setupView() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(stack)
        [titleLabel, bannerImageView].forEach { stack.addArrangedSubview($0) }
    }
    
    func bind() {
        guard let model = model else { return }
        titleLabel.attributedText = setupMutableString(title: model.title)
        bannerImageView.image = model.bannerImage
    }
    
    private func setupMutableString(title: String) -> NSMutableAttributedString {
        let mutableString = NSMutableAttributedString(string: title, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 24, weight: .bold)])
        mutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(named: "digioBlue")!, range: NSRange(location: 0, length:5))
        return mutableString
    }
}

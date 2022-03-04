//
//  ProductDetail.swift
//  DesafioDigio
//
//  Created by Everton Carneiro on 02/03/22.
//

import Foundation
import UIKit

class ProductDetail: UIViewController {
    typealias Model = DetailsModel
    
    var model: Model? {
        didSet {
            bind()
        }
    }
    
    struct DetailsModel {
        let title: String
        let logo: UIView
        let description: String?
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "digioBlue")!
        label.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var logoView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .natural
        return label
    }()
    
    
    lazy var stack: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.distribution = .fill
        stackview.spacing = 12
        stackview.translatesAutoresizingMaskIntoConstraints = false
        return stackview
    }()
    
    lazy var horizontalStack: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .horizontal
        stackview.distribution = .fill
        stackview.spacing = 12
        stackview.alignment = .firstBaseline
        stackview.translatesAutoresizingMaskIntoConstraints = false
        return stackview
    }()
    
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
        setupViews()
    }
    
    func setupViews() {
        view.addSubview(stack)
        
        [logoView, titleLabel].forEach { horizontalStack.addArrangedSubview($0) }
        [horizontalStack, descriptionLabel].forEach { stack.addArrangedSubview($0) }

        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
            
        ])

    }
    
    func bind() {
        guard let model = model else { return }
        titleLabel.text = model.title
        logoView = model.logo
        descriptionLabel.text = model.description
    }
}

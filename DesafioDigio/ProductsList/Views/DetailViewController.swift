//
//  DetailViewController.swift
//  DesafioDigio
//
//  Created by Everton Carneiro on 01/03/22.
//

import UIKit


class DetailViewController: UIViewController {
    typealias Model = DetailsModel
    
    var model: Model? {
        didSet {
            bind()
        }
    }
    
    struct DetailsModel {
        let title: String
        let bannerImage: UIImage?
        let description: String?
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: "digioBlue")!
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let bannerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 12
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
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
        stack.addArrangedSubview(titleLabel)
        [bannerImageView, titleLabel, descriptionLabel].forEach { stack.addArrangedSubview($0) }
        
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 16),
            bannerImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)

        ])

    }
    
    func bind() {
        guard let model = model else { return }
        titleLabel.text = model.title
        bannerImageView.image = model.bannerImage
        descriptionLabel.text = model.description
    }
}

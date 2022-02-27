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
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.systemGray
        
        let title = "digio Cash"
        var mutableString = NSMutableAttributedString(string: title, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 24, weight: .bold)])
        mutableString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(named: "digioBlue")!, range: NSRange(location:0,length:5))

        label.attributedText = mutableString
        return label
    }()
    
    
    lazy var stack: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.translatesAutoresizingMaskIntoConstraints = false
        return stackview
    }()

    struct CashSectionModel {
        let bannerImage: String
    }
    
    func setupLayout() {
        self.addSubview(stack)
        stack.addSubview(titleLabel)
    }
    
    func bind() {
        guard let model = model else { return }
        
    }
}

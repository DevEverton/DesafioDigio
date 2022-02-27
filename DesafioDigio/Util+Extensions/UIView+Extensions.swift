//
//  UIView+Extensions.swift
//  DesafioDigio
//
//  Created by Everton Carneiro on 27/02/22.
//

import UIKit

extension UIView {
    func pinToEdges(of view: UIView, withSpacing horizontal: CGFloat = 0) {
        NSLayoutConstraint.activate([
            self.topAnchor.constraint(equalTo: view.topAnchor),
            self.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: horizontal),
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            self.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: horizontal),
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

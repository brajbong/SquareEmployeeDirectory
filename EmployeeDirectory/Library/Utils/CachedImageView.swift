//
//  CachedImageView.swift
//  EmployeeDirectory
//
//  Created by Rajbongshi, Bhaskar on 9/3/19.
//  Copyright © 2019 Rajbongshi, Bhaskar. All rights reserved.
//
import UIKit

class CachedImageView: UIImageView {
    private lazy var imageService: ImageService = ImageService(networkService: NetworkService(), cacheService: CacheService())
    private let activityIndicatorView: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(style: .whiteLarge)
        aiv.translatesAutoresizingMaskIntoConstraints = false
        return aiv
    }()
    
    override init(frame: CGRect = CGRect.zero) {
        super.init(frame: frame)
        self.contentMode = .scaleAspectFill
        self.layer.masksToBounds = true
        layoutActivityIndicator()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layoutActivityIndicator() {
        activityIndicatorView.removeFromSuperview()
        addSubview(activityIndicatorView)
        NSLayoutConstraint.activate([
            activityIndicatorView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            ])
        
        if self.image == nil {
            activityIndicatorView.startAnimating()
        }
    }
    
    override func layoutSubviews() {
        self.layer.cornerRadius = self.bounds.width / 2
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.darkGray.cgColor
    }
    
    func loadImage(from endPoint: String, placeholder: String) {
        
        guard let url = URL(string: endPoint) else {
            return
        }
        
        imageService.fetchImage(for: url) { image in
            let image = image ?? UIImage(named: placeholder)
            DispatchQueue.main.async {
                self.image = image
                self.activityIndicatorView.stopAnimating()
            }
        }
    }
    
}

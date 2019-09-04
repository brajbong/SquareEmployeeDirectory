//
//  EmptyView.swift
//  EmployeeDirectory
//
//  Created by Rajbongshi, Bhaskar on 9/3/19.
//  Copyright © 2019 Rajbongshi, Bhaskar. All rights reserved.
//

import UIKit

final class EmptyView: UIView {
    public var text: String = "" {
        didSet {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.label.text = self.text
            }
        }
    }
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "icons8-empty-box-480")
        return imageView
    }()
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        return label
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    required init(text: String = "") {
        super.init(frame: .zero)
        isUserInteractionEnabled = false
        [imageView, label].forEach {
            addSubview($0)
        }
        label.text = text
        setupConstraints()
    }
}

extension EmptyView {
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.4),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1),
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.widthAnchor.constraint(equalTo: widthAnchor),
            label.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10)
            ])
    }
}

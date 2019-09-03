//
//  NSLayoutConstraint+Extension.swift
//  EmployeeDirectory
//
//  Created by Rajbongshi, Bhaskar on 9/3/19.
//  Copyright © 2019 Rajbongshi, Bhaskar. All rights reserved.
//

import UIKit

extension NSLayoutConstraint {
    static func activate(_ constraints: [NSLayoutConstraint]) {
        constraints.forEach {
            ($0.firstItem as? UIView)?.translatesAutoresizingMaskIntoConstraints = false
            $0.isActive = true
        }
    }
    
    static func pin(view: UIView, toEdgesOf anotherView: UIView) {
        activate([
            view.topAnchor.constraint(equalTo: anotherView.topAnchor),
            view.leftAnchor.constraint(equalTo: anotherView.leftAnchor),
            view.rightAnchor.constraint(equalTo: anotherView.rightAnchor),
            view.bottomAnchor.constraint(equalTo: anotherView.bottomAnchor)
            ])
    }
}

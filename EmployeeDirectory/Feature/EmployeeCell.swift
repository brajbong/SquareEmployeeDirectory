//
//  EmployeeCellTableViewCell.swift
//  EmployeeDirectory
//
//  Created by Rajbongshi, Bhaskar on 9/2/19.
//  Copyright © 2019 Rajbongshi, Bhaskar. All rights reserved.
//

import UIKit

class EmployeeCell: UITableViewCell {
    var employee: Employee? {
        didSet {
            setEmployeeData()
        }
    }
    
    private func setEmployeeData() {
        guard let employee = employee else { return }
        namelabel.text = employee.fullName
        desclabel.text = employee.biography ?? ""
        emailLabel.text = employee.emailAddress
        guard let photoUrl = employee.photoUrlSmall else {
            empImageView.image = UIImage(named: "profile-icon-empty")
            return
        }
        empImageView.loadImage(from: photoUrl, placeholder: "profile-icon-empty")
    }
    
    private (set) lazy var empImageView: CachedImageView = {
       let imageView = CachedImageView()
        return imageView
    }()
    
    private (set) lazy var namelabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        return label
    }()
    
    private (set) lazy var desclabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = UIFont.preferredFont(forTextStyle: .body)
        return label
    }()
    
    private (set) lazy var emailLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        label.textAlignment = .left
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(empImageView)
        contentView.addSubview(namelabel)
        contentView.addSubview(desclabel)
        contentView.addSubview(emailLabel)
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}

extension EmployeeCell {
    private func setupConstraints() {
        let marginGuide = contentView.layoutMarginsGuide
        NSLayoutConstraint.activate([
            empImageView.topAnchor.constraint(equalTo: marginGuide.topAnchor),
            empImageView.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor),
            empImageView.widthAnchor.constraint(equalToConstant: 90),
            empImageView.heightAnchor.constraint(equalToConstant: 90),
            
            namelabel.topAnchor.constraint(equalTo: marginGuide.topAnchor),
            namelabel.leadingAnchor.constraint(equalTo: empImageView.trailingAnchor, constant: 4),
            namelabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor),

            desclabel.topAnchor.constraint(equalTo: namelabel.bottomAnchor),
            desclabel.leadingAnchor.constraint(equalTo: empImageView.trailingAnchor, constant: 4),
            desclabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor),
            
            emailLabel.topAnchor.constraint(equalTo: desclabel.bottomAnchor),
            emailLabel.leadingAnchor.constraint(equalTo: empImageView.trailingAnchor, constant: 4),
            emailLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor),

            marginGuide.bottomAnchor.constraint(greaterThanOrEqualTo: empImageView.bottomAnchor, constant: 10),
            marginGuide.bottomAnchor.constraint(greaterThanOrEqualTo: emailLabel.bottomAnchor, constant: 10)
        ])
    }
}

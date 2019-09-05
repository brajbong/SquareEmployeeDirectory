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
        teamLabel.text = employee.team
        empTypeLabel.text = employee.employeeType.type()
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
    
    private (set) lazy var teamLabel : UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        label.textAlignment = .left
        return label
    }()
    
    private (set) lazy var empTypeLabel : UILabel = {
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
        contentView.addSubview(teamLabel)
        contentView.addSubview(empTypeLabel)
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}

extension EmployeeCell {
    private func setupConstraints() {
        let marginGuide = contentView.layoutMarginsGuide
        let verticalOffset: CGFloat = 4
        let horizontalOffset: CGFloat = 4
        let bottomMargin: CGFloat = 10
        let imageViewWidth: CGFloat = 90
        NSLayoutConstraint.activate([
            empImageView.topAnchor.constraint(equalTo: marginGuide.topAnchor),
            empImageView.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor),
            empImageView.widthAnchor.constraint(equalToConstant: imageViewWidth),
            empImageView.heightAnchor.constraint(equalTo: empImageView.widthAnchor),
            
            namelabel.topAnchor.constraint(equalTo: marginGuide.topAnchor),
            namelabel.leadingAnchor.constraint(equalTo: empImageView.trailingAnchor, constant: horizontalOffset),
            namelabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor),

            desclabel.topAnchor.constraint(equalTo: namelabel.bottomAnchor, constant: verticalOffset),
            desclabel.leadingAnchor.constraint(equalTo: empImageView.trailingAnchor, constant: horizontalOffset),
            desclabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor),
            
            emailLabel.topAnchor.constraint(equalTo: desclabel.bottomAnchor, constant: verticalOffset),
            emailLabel.leadingAnchor.constraint(equalTo: empImageView.trailingAnchor, constant: horizontalOffset),
            emailLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor),
            
            teamLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: verticalOffset),
            teamLabel.leadingAnchor.constraint(equalTo: empImageView.trailingAnchor, constant: horizontalOffset),
            teamLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor),
            
            empTypeLabel.topAnchor.constraint(equalTo: teamLabel.bottomAnchor, constant: verticalOffset),
            empTypeLabel.leadingAnchor.constraint(equalTo: empImageView.trailingAnchor, constant: horizontalOffset),
            empTypeLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor),

            marginGuide.bottomAnchor.constraint(greaterThanOrEqualTo: empImageView.bottomAnchor, constant: bottomMargin),
            marginGuide.bottomAnchor.constraint(greaterThanOrEqualTo: empTypeLabel.bottomAnchor, constant: bottomMargin)
        ])
    }
}

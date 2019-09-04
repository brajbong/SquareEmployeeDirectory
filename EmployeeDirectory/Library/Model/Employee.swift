//
//  Employee.swift
//  EmployeeDirectory
//
//  Created by Rajbongshi, Bhaskar on 8/30/19.
//  Copyright © 2019 Rajbongshi, Bhaskar. All rights reserved.
//

import Foundation

struct Employee: Decodable {
    enum EmployeeType: String, Decodable {
        case FULL_TIME
        case PART_TIME
        case CONTRACTOR
    }
    
    let id: String
    let fullName: String
    let phoneNumber: String?
    let emailAddress: String
    let biography: String?
    let photoUrlSmall: String?
    let photoUrlLarge: String?
    let team: String
    let employeeType: EmployeeType
    
    enum CodingKeys: String, CodingKey {
        case id = "uuid"
        case fullName = "full_name"
        case phoneNumber = "phone_number"
        case emailAddress = "email_address"
        case biography
        case photoUrlSmall = "photo_url_small"
        case photoUrlLarge = "photo_url_large"
        case team
        case employeeType = "employee_type"
    }
    
    static func make(data: Data) -> [Employee]? {
        return try? JSONDecoder().decode([Employee].self, from: data)
    }
}

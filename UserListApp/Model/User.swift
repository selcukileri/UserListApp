//
//  User.swift
//  UserListApp
//
//  Created by Selçuk İleri on 29.01.2025.
//

import Foundation

struct User: Codable {
    let id: Int
    let name: String
    let username: String
    let email: String
    let phone: String
    let website: String
}

//
//  user.swift
//  FilteringList
//
//  Created by RichK on 8/8/20.
//

import Foundation

struct User: Decodable, Identifiable {
    let id: UUID
    let name: String
    let company: String
    let email: String
    let phone: String
    let address: String
}

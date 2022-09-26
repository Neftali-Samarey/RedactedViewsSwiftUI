//
//  User.swift
//  RedactedViewModifier
//
//  Created by Neftali Samarey on 9/26/22.
//

import Foundation

struct User: Decodable {
    var users: [People] = []
}

struct People: Identifiable, Decodable {
    var id: Int
    var firstName: String
    var lastName: String
    var image: String
    var age: Int
}

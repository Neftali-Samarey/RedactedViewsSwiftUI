//
//  Post.swift
//  RedactedViewModifier
//
//  Created by Neftali Samarey on 9/24/22.
//

import Foundation

// Identifiable - Each element has a unique ID.
// Decodable - Can be decoded via JSON

struct Post: Identifiable, Decodable {
    var id: Int
    var name: String
}

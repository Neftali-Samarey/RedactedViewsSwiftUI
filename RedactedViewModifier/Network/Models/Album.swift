//
//  Album.swift
//  RedactedViewModifier
//
//  Created by Neftali Samarey on 9/26/22.
//

import Foundation

struct Album: Identifiable, Decodable {
    var id: Int
    var title: String
    var url: String
    var thumbnailUrl: String
}

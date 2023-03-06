//
//  Filter.swift
//  FoodDeliveryTest
//
//  Created by Geovanni Fuentes on 2023-03-04.
//

import Foundation

struct Filter: Decodable {
    // MARK: - Properties
    let id: String
    let name: String
    let imageUrl: String
    var isSelected = false
    
    // MARK: - Init
    /// Init used for decoder
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(String.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        imageUrl = try values.decode(String.self, forKey: .imageUrl)
    }
    
    /// Init used for decoder
    init(id: String, name: String, imageUrl: String) {
        self.id = id
        self.name = name
        self.imageUrl = imageUrl
    }
}

// MARK: - CondingKeys
extension Filter {
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case imageUrl = "image_url"
    }
}

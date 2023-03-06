//
//  Restaurant.swift
//  FoodDeliveryTest
//
//  Created by Geovanni Fuentes on 2023-03-04.
//

import Foundation

struct Restaurant: Decodable {
    // MARK: - Properties
    let id: String
    let name: String
    let rating: Double
    let filterIds: [String]
    let imageUrl: String
    let deliveryTimeMinutes: Int32
    var isVisible = true
    var tags = ""
    
    // MARK: - Init
    /// Init used for decoder
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(String.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        rating = try values.decode(Double.self, forKey: .rating)
        filterIds = try values.decode([String].self, forKey: .filterIds)
        imageUrl = try values.decode(String.self, forKey: .imageUrl)
        deliveryTimeMinutes = try values.decode(Int32.self, forKey: .deliveryTimeMinutes)
    }
    
    /// Init used for mock data
    init(id: String, name: String, rating: Double, filterIds: [String], imageUrl: String, deliveryTimeMinutes: Int32) {
        self.id = id
        self.name = name
        self.rating = rating
        self.filterIds = filterIds
        self.imageUrl = imageUrl
        self.deliveryTimeMinutes = deliveryTimeMinutes
    }
}

// MARK: - CodingKeys
extension Restaurant {
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case rating
        case filterIds
        case imageUrl = "image_url"
        case deliveryTimeMinutes = "delivery_time_minutes"
    }
}

// MARK: - Helpers
struct RestaurantResponse: Decodable {
    let restaurants: [Restaurant]
}

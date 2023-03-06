//
//  RestaurantStatus.swift
//  FoodDeliveryTest
//
//  Created by Geovanni Fuentes on 2023-03-05.
//

import Foundation

struct RestaurantStatus: Decodable {
    // MARK: - Properties
    let restaurantId: String
    let isOpen: Bool
    
    // MARK: - Properties
    /// Init used for decoder
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        restaurantId = try values.decode(String.self, forKey: .restaurantId)
        isOpen = try values.decode(Bool.self, forKey: .isOpen)
    }
    
    /// Init used for mock data
    init(restaurantId: String, isOpen: Bool) {
        self.restaurantId = restaurantId
        self.isOpen = isOpen
    }
}

// MARK: - StringKeys
extension RestaurantStatus {
    enum CodingKeys: String, CodingKey {
        case restaurantId = "restaurant_id"
        case isOpen = "is_currently_open"
    }
}

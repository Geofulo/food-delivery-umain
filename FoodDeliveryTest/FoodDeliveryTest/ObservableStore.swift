//
//  ObservableStore.swift
//  FoodDeliveryTest
//
//  Created by Geovanni Fuentes on 2023-03-06.
//

import Foundation
import Combine
import Dependencies

class ObservableStore: ObservableObject, DependencyKey {
    // MARK: - Private properties
    @Published var currentRestaurant: Restaurant
    
    /// Updates the current selected meal
    /// - Parameters:
    /// - id: Meal id
    func onRestaurantSelected(_ restaurant: Restaurant) {
        currentRestaurant = restaurant
    }
    
    init() {
        currentRestaurant = Restaurant(id: "", name: "", rating: 0, filterIds: [], imageUrl: "", deliveryTimeMinutes: 0)
    }
}

// MARK: - DI
extension ObservableStore {
    static var liveValue = ObservableStore()
}

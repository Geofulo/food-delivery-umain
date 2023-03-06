//
//  DataManager.swift
//  FoodDeliveryTest
//
//  Created by Geovanni Fuentes on 2023-03-04.
//

import Foundation
import Combine
import Dependencies

struct DataManager: DependencyKey {
    // MARK: - Endpoints
    var allRestaurants: () -> AnyPublisher<RestaurantResponse, Error>
    var restaurantStatus: (_ id: String) -> AnyPublisher<RestaurantStatus, Error>
    var filter: (_ id: String) -> AnyPublisher<Filter, Error>
}

// MARK: - Implementation
extension DataManager {
    static var liveValue = Self(
        allRestaurants: { NetworkClient.perform(NetworkConstants.Restaurants.fetchAllRequestUrl) },
        restaurantStatus: { NetworkClient.perform(NetworkConstants.Restaurants.fetchStatusRequestUrl($0)) },
        filter: { NetworkClient.perform(NetworkConstants.Filters.fetchRequestUrl($0)) }
    )
    
    static var previewValue = Self(
        allRestaurants: {
            Just(RestaurantResponse(restaurants: [
                Restaurant(
                    id: "0",
                    name: "Restaurant",
                    rating: 5.0,
                    filterIds: [],
                    imageUrl: "https://food-delivery.umain.io/images/restaurant/coffee.png",
                    deliveryTimeMinutes: 30
                ),
                Restaurant(
                    id: "1",
                    name: "Restaurant",
                    rating: 4.0,
                    filterIds: [],
                    imageUrl: "https://food-delivery.umain.io/images/restaurant/coffee.png",
                    deliveryTimeMinutes: 20
                ),
            ]))
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
        },
        restaurantStatus: { _ in
            Just(RestaurantStatus(restaurantId: "0", isOpen: true))
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
        },
        filter: { _ in
            Just(Filter(id: "0", name: "Filter", imageUrl: "https://food-delivery.umain.io/images/filter/filter_top_rated.png"))
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
    )
}

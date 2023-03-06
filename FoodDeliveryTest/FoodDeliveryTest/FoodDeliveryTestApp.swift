//
//  FoodDeliveryTestApp.swift
//  FoodDeliveryTest
//
//  Created by Geovanni Fuentes on 2023-03-03.
//

import SwiftUI

@main
struct FoodDeliveryTestApp: App {
    var body: some Scene {
        WindowGroup {
            RestaurantList(viewModel: RestaurantListViewModel())
        }
    }
}

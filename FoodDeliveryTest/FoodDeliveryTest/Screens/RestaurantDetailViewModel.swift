//
//  RestaurantDetailViewModel.swift
//  FoodDeliveryTest
//
//  Created by Geovanni Fuentes on 2023-03-04.
//

import SwiftUI
import Combine
import Dependencies

final class RestaurantDetailViewModel: ObservableObject {
    // MARK: - Dependencies
    @Dependency(\.dataManager) var dataManager
    @Dependency(\.store) var store
    
    // MARK: - Private properties
    @Published private(set) var status: RestaurantStatus?
    private var cancellables: Set<AnyCancellable> = []
}

// MARK: - Fetch data
extension RestaurantDetailViewModel {
    func loadRestaurantStatus() {
        dataManager
            .restaurantStatus(store.currentRestaurant.id)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(_):
                    print("[Network] Failed load restaurant status")
                case .finished:
                    print("[Network] Finished load restaurant status")
                }
            }, receiveValue: { [weak self] value in
                self?.status = value
            })
            .store(in: &cancellables)
    }
}

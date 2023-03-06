//
//  RestaurantListViewModel.swift
//  FoodDeliveryTest
//
//  Created by Geovanni Fuentes on 2023-03-04.
//

import SwiftUI
import Combine
import Dependencies

final class RestaurantListViewModel: ObservableObject {
    // MARK: - Dependencies
    @Dependency(\.dataManager) var dataManager
    @Dependency(\.store) var store
    
    // MARK: - Private properties
    @Published private(set) var restaurants: [Restaurant] = []
    @Published private(set) var visibleRestaurants: [Restaurant] = []
    @Published private(set) var filtersId: [String] = []
    @Published private(set) var filters: [Filter] = []
    @Published private(set) var selectedFilters: [Filter] = []
    @Published private(set) var error: Error?
    private var cancellables: Set<AnyCancellable> = []
    
    // MARK: - Init
    init() {
        subscribe()
    }
    
    // MARK: - Subscribe to publishers
    private func subscribe() {
        // Used to get the *filter id*
        $restaurants
            .compactMap { restaurants in
                var result: [String] = []
                for item in restaurants {
                    for id in item.filterIds {
                        result.appendIfNotContains(id)
                    }
                }
                return result
            }
            .removeDuplicates()
            .assign(to: &$filtersId)
        
        $selectedFilters
            .combineLatest($restaurants)
            .compactMap { (filters, restaurants) in
                if filters.count == 0 {
                    return restaurants
                }
                
                var result: [Restaurant] = []
                for filter in filters {
                    for item in restaurants.filter({ $0.filterIds.contains(where: { $0 == filter.id }) }) {
                        if !result.contains(where: { $0.id == item.id }) {
                            result.append(item)
                        }
                    }
                }
                return result
            }
            .assign(to: &$visibleRestaurants)
        
        $filtersId
            .sink(receiveValue: { [weak self] filters in
                for id in filters {
                    self?.loadFilter(id)
                }
            })
            .store(in: &cancellables)
    }
}

// MARK: - Fetch data
extension RestaurantListViewModel {
    func loadRestaurants() {
        dataManager
            .allRestaurants()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    self?.error = error
                case .finished:
                    self?.error = nil
                    print("[Network] Finished load restaurants")
                }
            }, receiveValue: { [weak self] value in
                self?.restaurants = value.restaurants
                self?.visibleRestaurants = value.restaurants
            })
            .store(in: &cancellables)
    }
    
    private func loadFilter(_ id: String) {
        dataManager
            .filter(id)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(_):
                    print("[Network] Failed load filter")
                case .finished:
                    print("[Network] Finished load filter")
                }
            }, receiveValue: { [weak self] value in
                if let index = self?.filters.firstIndex(where: { $0.id == value.id }) {
                    self?.filters[index] = value
                } else {
                    self?.filters.append(value)
                }
            })
            .store(in: &cancellables)
    }
}

// MARK: - User interaction actions
extension RestaurantListViewModel {
    func selectRestaurant(_ restaurant: Restaurant, tags: String = "") {
        store.currentRestaurant = restaurant
        store.currentRestaurant.tags = tags
    }
    
    func selectFilter(_ id: String) {
        if let index = filters.firstIndex(where: { $0.id == id }) {
            filters[index].isSelected.toggle()
            
            let filter = filters[index]
            if let index = selectedFilters.firstIndex(where: { $0.id == filter.id }) {
                selectedFilters.remove(at: index)
            } else {
                selectedFilters.append(filter)
            }
        }
    }
}

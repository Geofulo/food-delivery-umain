//
//  DependencyValues+Extensions.swift
//  FoodDeliveryTest
//
//  Created by Geovanni Fuentes on 2023-03-05.
//

import Foundation
import Dependencies

extension DependencyValues {
    var dataManager: DataManager {
        get { self[DataManager.self] }
        set { self[DataManager.self] = newValue }
    }
    
    var store: ObservableStore {
        get { self[ObservableStore.self] }
        set { self[ObservableStore.self] = newValue }
    }
}

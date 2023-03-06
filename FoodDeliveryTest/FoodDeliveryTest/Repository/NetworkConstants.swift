//
//  NetworkConstants.swift
//  FoodDeliveryTest
//
//  Created by Geovanni Fuentes on 2023-03-04.
//

import Foundation

struct NetworkConstants {
    struct Restaurants {
        static let fetchAllRequestUrl = "\(baseUrl)/restaurants"
        static func fetchStatusRequestUrl(_ id: String) -> String { "\(baseUrl)/open/\(id)" }
    }
    
    struct Filters {
        static func fetchRequestUrl(_ id: String) -> String { "\(baseUrl)/filter/\(id)" }
    }
}

extension NetworkConstants {
    static let baseUrl = "https://food-delivery.umain.io/api/v1"
}

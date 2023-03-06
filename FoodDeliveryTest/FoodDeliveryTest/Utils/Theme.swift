//
//  Constants.swift
//  FoodDeliveryTest
//
//  Created by Geovanni Fuentes on 2023-03-03.
//

import Foundation
import SwiftUI

struct Theme {
    struct Size {
        static let restaurantCardHeight = 196.0
        static let imageHeight = 132.0
        static let chipImageSize = 48.0
        static let detailImageHeight = 220.0
        static let detailCardHeight = 144.0
        static let iconSmall = 10.0
        static let iconMedium = 24.0
        static let iconLarge = 54.0
        static let tryAgainButton = 80.0
    }
    
    struct Padding {
        static let cardPadding = 8.0
        static let detailCardPadding = 16.0
        static let chipTitlePadding = 16.0
        static let detailCardSpacing = 0.0
        static let chipSpacing = 8.0
        static let chipPadding = 16.0
        static let listRestaurantsPadding = 16.0
        static let listRestaurantsSpacing = 16.0
        static let backButtonTopPadding = 16.0
    }
    
    struct Radius {
        static let cardRadius = 12.0
        static let chipRadius = 24.0
    }
    
    struct Colors {
        static let standardShadow = Color.black.opacity(0.1)
        static let cardBackground = Color.white
        static let timeIcon = SystemColors.brightRed
        static let ratingIcon = SystemColors.yellowStar
        static let chipBackground = Color.white
        static let chipSelectedBackground = SystemColors.selected
        static let statusOpen = SystemColors.positive
        static let statusClosed = SystemColors.negative
        static let chipText = Color.black
        static let chipSelectedText = Color.white
    }
    
    struct Resources {
        static let ratingIcon = "star.fill"
        static let timeIcon = "clock"
        static let umainIcon = "umain_icon"
    }
}

extension Theme.Colors {
    struct SystemColors {
        // TODO: Fix usage of Color from RGB or Hex code
//        static let brightRed = Color(red: 255, green: 82, blue: 82)
//        static let yellowStar = Color(red: 249, green: 202, blue: 36)
//        static let selected = Color(red: 89, green: 64, blue: 39)
//        static let positive = Color(red: 18, green: 80, blue: 44)
//        static let negative = Color(red: 75, green: 22, blue: 17)
//        static let subtitle = Color(red: 60, green: 60, blue: 60)
        static let brightRed = Color.red.opacity(0.8)
        static let yellowStar = Color.yellow
        static let selected = Color.yellow.opacity(0.5)
        static let positive = Color.green
        static let negative = Color.red
        static let subtitle = Color.gray
    }
}

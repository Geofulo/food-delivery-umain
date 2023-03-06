//
//  RestaurantCard.swift
//  FoodDeliveryTest
//
//  Created by Geovanni Fuentes on 2023-03-03.
//

import SwiftUI

struct RestaurantCard: View {
    // MARK: - Properties
    var title: String
    var tags: String
    var deliveryTime: String
    var rating: String
    var imageUrl: String
    
    // MARK: - View
    var body: some View {
        VStack(spacing: 0) {
            cardImage
            cardInfo
        }
        .background(Theme.Colors.cardBackground)
        .cornerRadius(Theme.Radius.cardRadius, corners: [.topLeft, .topRight])
        .shadow(color: Theme.Colors.standardShadow, radius: 4, x: 0, y: 4)
    }
    
    // MARK: - Subviews
    @ViewBuilder private var cardImage: some View {
        if let source = imageSource {
            AsyncImage(url: source, content: { image in
                image
                    .resizable()
                    .scaledToFill()
                    .frame(minWidth: 0, maxWidth: 800, minHeight: 0, maxHeight: Theme.Size.imageHeight)
                    .clipped()
            }, placeholder: {
                ProgressView()
            })
        } else {
            EmptyView()
        }
    }
    
    @ViewBuilder private var cardInfo: some View {
        VStack(alignment: .leading) {
            HStack {
                Label(title)
                    .textStyle(.title1)
                
                Spacer()
                
                Label(rating)
                    .textStyle(.footer)
                    .leadingIcon(Theme.Resources.ratingIcon, Theme.Colors.ratingIcon)
            }
            VStack(alignment: .leading) {
                Label(tags)
                    .textStyle(.subtitle)
                    .setTextColor(.gray)
                
                Label(deliveryTimeText)
                    .textStyle(.footer)
                    .leadingIcon(Theme.Resources.timeIcon, Theme.Colors.timeIcon)
            }
        }
        .padding(Theme.Padding.cardPadding)
    }
}

// MARK: - Private properties
extension RestaurantCard {
    /// Converts ``imageUrl`` into ``URL``
    private var imageSource: URL? {
        URL(string: imageUrl)
    }
    
    /// Converts ``deliveryTime`` into formatted ``String``
    private var deliveryTimeText: String {
        "\(deliveryTime) mins"
    }
}

struct RestaurantCard_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantCard(
            title: "Title",
            tags: "Tag - Tag - Tag",
            deliveryTime: "1h",
            rating: "5",
            imageUrl: "https://food-delivery.umain.io/images/restaurant/coffee.png"
        )
    }
}

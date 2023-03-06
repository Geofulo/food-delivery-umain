//
//  RestaurantDetail.swift
//  FoodDeliveryTest
//
//  Created by Geovanni Fuentes on 2023-03-04.
//

import SwiftUI
import Combine
import Dependencies

struct RestaurantDetail: View {
    // MARK: - Properties
    @ObservedObject var viewModel: RestaurantDetailViewModel
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    // MARK: - View
    var body: some View {
        ZStack(alignment: .top) {
            header
            restaurantCard
        }
        .frame(minHeight: 0, maxHeight: .infinity, alignment: .top)
        .onAppear {
            viewModel.loadRestaurantStatus()
        }
        
    }
    
    // MARK: - Subviews
    @ViewBuilder private var header: some View {
        ZStack(alignment: .topLeading) {
            AsyncImage(url: imageSource, content: { image in
                image
                    .resizable()
                    .scaledToFill()
            }, placeholder: {
                ProgressView()
            })
            .frame(height: Theme.Size.detailImageHeight)
            
            Icon(systemIcon: "chevron.left")
                .iconType(.large)
                .font(.title)
                .padding(.top, Theme.Padding.backButtonTopPadding)
                .onTapGesture {
                    mode.wrappedValue.dismiss()
                }
        }
        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
    }
    
    @ViewBuilder private var restaurantCard: some View {
        DetailCard(
            title: viewModel.store.currentRestaurant.name,
            subtitle: viewModel.store.currentRestaurant.tags,
            status: status
        )
        .frame(minWidth: 0, maxWidth: .infinity)
        .padding(Theme.Padding.detailCardPadding)
        .offset(y: Theme.Size.detailImageHeight / 2)
    }
}

// MARK: - Private properties
extension RestaurantDetail {
    /// Converts ``Restaurant.imageUrl`` into ``URL``
    private var imageSource: URL? {
        URL(string: viewModel.store.currentRestaurant.imageUrl)
    }
    
    /// Converts ``RestaurantStatus`` into ``DetailCard.Status``
    private var status: DetailCard.Status {
        guard let restaurantStatus = viewModel.status else { return .none }
        if restaurantStatus.isOpen {
            return .open
        } else {
            return .closed
        }
    }
}


struct RestaurantDetail_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantDetail(
            viewModel: withDependencies {
                $0.dataManager.restaurantStatus = { _ in
                    Just(RestaurantStatus(restaurantId: "0", isOpen: true))
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()
                }
                $0.store.currentRestaurant = Restaurant(
                    id: "1",
                    name: "Test restaurant",
                    rating: 0,
                    filterIds: [],
                    imageUrl: "https://food-delivery.umain.io/images/restaurant/coffee.png",
                    deliveryTimeMinutes: 0)
            } operation: {
                RestaurantDetailViewModel()
            }
        )
    }
}

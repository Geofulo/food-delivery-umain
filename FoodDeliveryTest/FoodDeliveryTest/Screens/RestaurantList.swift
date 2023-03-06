//
//  RestaurantList.swift
//  FoodDeliveryTest
//
//  Created by Geovanni Fuentes on 2023-03-04.
//

import SwiftUI
import Combine
import Dependencies

struct RestaurantList: View {
    // MARK: - Properties
    @ObservedObject var viewModel: RestaurantListViewModel
    @State private var isRestaurantDetailPresented = false
    
    // MARK: - View
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            header
            filters
            restaurants
            errorMessage
        }
        .sheet(isPresented: $isRestaurantDetailPresented) {
            RestaurantDetail(viewModel: RestaurantDetailViewModel())
        }
        .onAppear {
            viewModel.loadRestaurants()
        }
    }
    
    // MARK: - Subviews
    @ViewBuilder private var header: some View {
        Icon(Theme.Resources.umainIcon)
            .iconType(.large)
            .padding(.leading, Theme.Padding.listRestaurantsPadding)
    }
    
    @ViewBuilder private var filters: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: Theme.Padding.chipPadding) {
                ForEach(viewModel.filters, id: \.id) { item in
                    let chip = FilterChip(
                        title: item.name,
                        imageUrl: item.imageUrl,
                        isSelected: Binding(get: { item.isSelected }, set: { _ in
                            viewModel.selectFilter(item.id)
                        }))
                    .padding([.vertical], Theme.Padding.chipPadding)
                    
                    let chipWithLeadingPadding = addChipLeadingPadding(chip, filter: item)
                    addChipTrailingPadding(chipWithLeadingPadding, filter: item)
                }
            }
        }
        .fixedSize(horizontal: false, vertical: true)
    }
    
    @ViewBuilder private var restaurants: some View {
        ScrollView {
            LazyVStack(spacing: Theme.Padding.listRestaurantsSpacing) {
                ForEach(viewModel.visibleRestaurants, id: \.id) { item in
                    let tags = tagsText(item)
                    RestaurantCard(
                        title: item.name,
                        tags: tags,
                        deliveryTime: "\(item.deliveryTimeMinutes)",
                        rating: "\(item.rating)",
                        imageUrl: item.imageUrl)
                    .onTapGesture {
                        viewModel.selectRestaurant(item, tags: tags)
                        isRestaurantDetailPresented.toggle()
                    }
                }
            }
            .padding(Theme.Padding.listRestaurantsPadding)
        }
    }
    
    @ViewBuilder private var errorMessage: some View {
        if viewModel.error != nil {
            Button { [weak viewModel] in
                viewModel?.loadRestaurants()
            } label: {
                Spacer()
                Label("Try again")
                    .textStyle(.headline2)
                    .foregroundColor(.black)
                    .frame(alignment: .center)
                Spacer()
            }
            .offset(x: 0, y: -120)
        }
    }
    
    // MARK: - View configurations
    @ViewBuilder private func addChipLeadingPadding<Content: View>(_ content: Content, filter: Filter) -> some View {
        if let index = viewModel.filters.firstIndex(where: { $0.id == filter.id }), index == 0 {
            content
                .padding(.leading, Theme.Padding.chipPadding)
        } else {
            content
        }
    }
    
    @ViewBuilder private func addChipTrailingPadding<Content: View>(_ content: Content, filter: Filter) -> some View {
        if let index = viewModel.filters.firstIndex(where: { $0.id == filter.id }), index == viewModel.filters.count - 1 {
            content
                .padding(.trailing, Theme.Padding.chipPadding)
        } else {
            content
        }
    }
}

// MARK: - Private func
extension RestaurantList {
    /// Get inline text of ``Restaurant`` filters as tags
    private func tagsText(_ restaurant: Restaurant) -> String {
        let filters = Array(viewModel.filters.filter { restaurant.filterIds.contains($0.id) })
        return filters.map({ $0.name }).joined(separator: " - ")
    }
}

struct RestaurantList_Previews: PreviewProvider {
    static var previews: some View {
        RestaurantList(viewModel: RestaurantListViewModel())
        RestaurantList(
            viewModel: withDependencies {
                $0.dataManager.allRestaurants = {
                    Just(RestaurantResponse(restaurants: []))
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()
                }
            } operation: {
                RestaurantListViewModel()
            }
        )
        RestaurantList(
            viewModel: withDependencies {
                $0.dataManager.allRestaurants = {
                    Fail(error: NSError(domain: "", code: 1))
                        .eraseToAnyPublisher()
                }
            } operation: {
                RestaurantListViewModel()
            }
        )
    }
}

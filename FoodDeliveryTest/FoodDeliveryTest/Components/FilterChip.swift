//
//  FilterChip.swift
//  FoodDeliveryTest
//
//  Created by Geovanni Fuentes on 2023-03-03.
//

import SwiftUI

struct FilterChip: View {
    // MARK: - Properties
    var title: String
    var imageUrl: String
    @Binding var isSelected: Bool
    
    // MARK: - View
    var body: some View {
        HStack(spacing: Theme.Padding.chipSpacing) {
            AsyncImage(url: imageSource, content: { image in
                image
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(Theme.Radius.chipRadius)
            }, placeholder: {
                ProgressView()
            })
            .frame(width: Theme.Size.chipImageSize, height: Theme.Size.chipImageSize)
            .rotationEffect(isSelected ? .degrees(0) : .degrees(360))
            
            Label(title)
                .textStyle(.title2)
                .padding(.trailing, Theme.Padding.chipTitlePadding)
        }
        .background(backgroundColor)
        .cornerRadius(Theme.Radius.chipRadius)
        .shadow(color: Theme.Colors.standardShadow, radius: 10, x: 0, y: 4)
        .onTapGesture {
            withAnimation(Animation.easeOut(duration: 0.8)) {
                isSelected.toggle()
            }
        }
    }
}

// MARK: - Private func
extension FilterChip {
    private var backgroundColor: Color {
        isSelected ? Theme.Colors.chipSelectedBackground : Theme.Colors.chipBackground
    }
    
    private var textColor: Color {
        isSelected ? Theme.Colors.chipSelectedText : Theme.Colors.chipText
    }
    
    private var imageSource: URL? {
        URL(string: imageUrl)
    }
}

struct FilterChip_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            FilterChip(
                title: "Large title",
                imageUrl: "https://food-delivery.umain.io/images/filter/filter_top_rated.png",
                isSelected: .constant(false)
            )
            .padding()
            
            FilterChip(
                title: "Title",
                imageUrl: "https://food-delivery.umain.io/images/filter/filter_top_rated.png",
                isSelected: .constant(true)
            )
            .padding()
        }
        .background(Color.gray)
    }
}

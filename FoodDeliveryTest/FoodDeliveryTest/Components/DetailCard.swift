//
//  DetailCard.swift
//  FoodDeliveryTest
//
//  Created by Geovanni Fuentes on 2023-03-03.
//

import SwiftUI

struct DetailCard: View {
    // MARK: - Properties
    var title: String
    var subtitle: String
    var status: Status
    
    enum Status {
        case open
        case closed
        case none
    }
    
    // MARK: - View
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: Theme.Padding.detailCardSpacing) {
                Label(title)
                    .textStyle(.headline1)
                
                Spacer()
                
                Label(subtitle)
                    .textStyle(.headline2)
                    .setTextColor(Theme.Colors.SystemColors.subtitle)
                
                Spacer()
                
                statusLabel
            }
            .padding(Theme.Padding.detailCardPadding)
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
        }
        .background(Theme.Colors.cardBackground)
        .cornerRadius(Theme.Radius.cardRadius)
        .shadow(color: Theme.Colors.standardShadow, radius: 4, x: 0, y: 4)
        .frame(height: Theme.Size.detailCardHeight)
    }
    
    // MARK: - Subviews
    @ViewBuilder private var statusLabel: some View {
        switch status {
        case .open:
            Label(statusText)
                .setTextColor(Theme.Colors.statusOpen)
                .textStyle(.title1)
        case .closed:
            Label(statusText)
                .textStyle(.title1)
                .setTextColor(Theme.Colors.statusClosed)
        case .none:
            EmptyView()
        }
    }
}

// MARK: - Private properties
extension DetailCard {
    /// Converts ``Status`` into ``String``
    private var statusText: String {
        switch status {
        case .open:
            return "Open"
        case .closed:
            return "Closed"
        case .none:
            return ""
        }
    }
}


struct DetailCard_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            DetailCard(
                title: "Title",
                subtitle: "Subtitle",
                status: .open
            )
            .padding()
            
            DetailCard(
                title: "Title",
                subtitle: "Subtitle",
                status: .closed
            )
            .padding()
        }
        .background(Color.gray)
    }
}


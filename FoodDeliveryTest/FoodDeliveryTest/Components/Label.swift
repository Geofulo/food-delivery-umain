//
//  Label.swift
//  FoodDeliveryTest
//
//  Created by Geovanni Fuentes on 2023-03-03.
//

import Foundation
import SwiftUI

struct Label: View {
    // MARK: - Properties
    private var text: String
    private var style = TextStyle.title1
    private var leadingIcon: String?
    private var textColor: Color?
    private var iconColor: Color?
    
    enum TextStyle {
        case title1
        case title2
        case subtitle
        case footer
        case headline1
        case headline2
    }
    
    // MARK: - View
    var body: some View {
        HStack {
            if let source = leadingIcon {
                Image(systemName: source)
                    .resizable()
                    .foregroundColor(iconColor)
                    .frame(width: Theme.Size.iconSmall, height: Theme.Size.iconSmall)
            }
            addStyle(label)
        }
    }
    
    // MARK: - Subviews
    @ViewBuilder private var label: some View {
        Text(text)
            .foregroundColor(textColor)
    }
    
    @ViewBuilder private func addStyle<Content: View>(_ content: Content) -> some View {
        switch style {
        case .title1:
            content.font(.custom("Helvetica", size: 18))
        case .title2:
            content.font(.custom("Poppins", size: 14))
        case .subtitle:
            content
                .font(.custom("Helvetica", size: 12))
                .foregroundColor(Theme.Colors.SystemColors.subtitle)
        case .footer:
            content.font(.custom("Inter", size: 10))
        case .headline1:
            content.font(.custom("Helvetica", size: 24))
        case .headline2:
            content.font(.custom("Helvetica", size: 16))
        }
    }
}

// MARK: - Init
extension Label {
    ///Initialize ``Label`` component with title text
    init(_ text: String) {
        self.text = text
    }
}

// MARK: - Func
extension Label {
    ///Sets ``TextStyle`` to the ``Label``
    func textStyle(_ style: TextStyle) -> Self {
        var mutatingSelf = self
        mutatingSelf.style = style
        return mutatingSelf
    }
    
    ///Sets an icon to the left side of the ``Label``
    /// - Parameters:
    /// - String: System icon name
    /// - Color: Tint color for the icon
    func leadingIcon(_ image: String, _ color: Color) -> Self {
        var mutatingSelf = self
        mutatingSelf.leadingIcon = image
        mutatingSelf.iconColor = color
        return mutatingSelf
    }
    
    ///Sets text color to the ``Label``
    func setTextColor(_ color: Color) -> Self {
        var mutatingSelf = self
        mutatingSelf.textColor = color
        return mutatingSelf
    }
}

struct Label_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Label("title1")
                .textStyle(.title1)
            
            Label("title2")
                .textStyle(.title2)
            
            Label("subtitle")
                .textStyle(.subtitle)
            
            Label("footer")
                .textStyle(.footer)
            
            Label("headline1")
                .textStyle(.headline1)
            
            Label("headline2")
                .textStyle(.headline2)
            
            Label("title1")
                .textStyle(.title1)
                .leadingIcon(Theme.Resources.ratingIcon, Theme.Colors.SystemColors.yellowStar)
            
            Label("title1")
                .textStyle(.subtitle)
                .leadingIcon(Theme.Resources.ratingIcon, .red)
            
            Label("title1")
                .textStyle(.title2)
                .setTextColor(Theme.Colors.SystemColors.subtitle)
                .leadingIcon(Theme.Resources.ratingIcon, .purple)
        }
        .padding()
        .background(Color.gray)
    }
}

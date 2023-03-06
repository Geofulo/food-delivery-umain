//
//  View+Extensions.swift
//  FoodDeliveryTest
//
//  Created by Geovanni Fuentes on 2023-03-03.
//

import Foundation
import UIKit
import SwiftUI

extension Array where Element == String {
    /// Append ``String`` element into the ``Array`` if does not exists already
    mutating func appendIfNotContains(_ element: String) {
        if self.first(where: { $0 == element }) == nil {
            self.append(element)
        }
    }
}

extension View {
    /// Set corner radius to specific corners of the View
    /// - Parameters:
    /// - CGFloat: Corner radius
    /// - UIRectCorner: Array of corners modified by the radius
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct RoundedCorner: Shape {
    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

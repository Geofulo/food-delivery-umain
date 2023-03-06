//
//  Icon.swift
//  FoodDeliveryTest
//
//  Created by Geovanni Fuentes on 2023-03-04.
//

import SwiftUI

struct Icon: View {
    // MARK: - Properties
    private var resourceUrl: String = ""
    private var systemIcon: String = ""
    private var type = IconType.small
    
    // MARK: - View
    var body: some View {
        if !resourceUrl.isEmpty {
            Image(resourceUrl)
                .frame(width: type.size, height: type.size)
        } else if !systemIcon.isEmpty {
            Image(systemName: systemIcon)
                .frame(width: type.size, height: type.size)
        }
    }
}

// MARK: - Init
extension Icon {
    /// Initialize ``Icon`` with a url
    init(_ url: String) {
        self.resourceUrl = url
    }
    
    /// Initialize ``Icon`` with a system icon
    init(systemIcon: String) {
        self.systemIcon = systemIcon
    }
}

// MARK: - Modifiers
extension Icon {
    enum IconType {
        case small
        case medium
        case large
        
        /// Get size of the ``Icon`` depending on the ``IconType``
        var size: CGFloat {
            switch self {
            case .small:
                return Theme.Size.iconSmall
            case .medium:
                return Theme.Size.iconMedium
            case .large:
                return Theme.Size.iconLarge
            }
        }
    }
}

// MARK: - Func
extension Icon {
    /// Sets the ``IconType`` to change the icon size
    func iconType(_ type: IconType) -> Self {
        var mutatingSelf = self
        mutatingSelf.type = type
        return mutatingSelf
    }
}

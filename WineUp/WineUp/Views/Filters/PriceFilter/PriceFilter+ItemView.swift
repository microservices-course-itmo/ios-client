//
//  PriceFilter+ItemView.swift
//  WineUp
//
//  Created by Nikolai Solonenko on 02.10.2020.
//

import SwiftUI

// MARK: - Constants

private extension Font {
    static let itemTitle: Font = .system(size: 13)
}

private extension Color {
    static let itemTitle: Color = .primary
    static let border = Color(.systemGray4)
}

private extension CGFloat {
    static let borderWidth: CGFloat = 1
    static let borderCornerRadius: CGFloat = 25
    static let borderHPadding: CGFloat = -10
    static let borderVPadding: CGFloat = -10
}

private extension LocalizedStringKey {
    static func lessThan(maxPriceRub: Int) -> LocalizedStringKey {
        return "До \(maxPriceRub)"
    }

    static func between(minPriceRub: Int, and maxPriceRub: Int) -> LocalizedStringKey {
        return "\(minPriceRub)-\(maxPriceRub)"
    }

    static func greaterTnan(minPriceRub: Int) -> LocalizedStringKey {
        return "Более \(minPriceRub)"
    }
}

// MARK: - View

extension PriceFilter {
    /// Predefined price interval non-interactive view
    struct PredefinedPriceIntervalView: View {

        let interval: PredefinedPriceInterval

        var body: some View {
            Text(title)
                .foregroundColor(.itemTitle)
                .font(.itemTitle)
                .overlay(
                    RoundedRectangle(cornerRadius: .borderCornerRadius)
                        .stroke(Color.border, lineWidth: .borderWidth)
                        .padding([.leading, .trailing], .borderHPadding)
                        .padding([.top, .bottom], .borderVPadding)
                )
        }
    }
}

// MARK: - Helpers

private extension PriceFilter.PredefinedPriceIntervalView {
    var title: LocalizedStringKey {
        switch interval {
        case .lessThan(let maxPriceRub):
            return .lessThan(maxPriceRub: Int(maxPriceRub))

        case let .between(minPriceRub, maxPriceRub):
            return .between(minPriceRub: Int(minPriceRub), and: Int(maxPriceRub))

        case .greaterThan(let minPriceRub):
            return .greaterTnan(minPriceRub: Int(minPriceRub))

        }
    }
}

// MARK: - Preview

#if DEBUG
struct PriceFilterItemView_Previews: PreviewProvider {
    private static let interval = PriceFilter.PredefinedPriceInterval.mockedData[0]

    static var previews: some View {
        Group {
            PriceFilter.PredefinedPriceIntervalView(interval: interval)
        }
        .previewLayout(.fixed(width: 414, height: 250))
    }
}
#endif

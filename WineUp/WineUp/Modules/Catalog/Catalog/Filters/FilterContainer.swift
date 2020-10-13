//
//  FilterContainer.swift
//  WineUp
//
//  Created by Dmitry Rebrik on 11.10.2020.
//

import SwiftUI

private extension CGFloat {
    static let applyButtonHeight: CGFloat = 40.0
}

struct FilterContainer<FilterView: IFilterView>: View {

    let finishAction: () -> Void
    let filter: FilterView

    // MARK: - Init

    init(filter: FilterView, finishAction: @escaping () -> Void) {
        self.filter = filter
        self.finishAction = finishAction
    }

    // MARK: - View

    var body: some View {
        VStack {
            HStack {
                Text(filter.title)
                    .fontWeight(.bold)
                    .padding([.top, .leading])
                    .lineLimit(1)

                Spacer()

                if filter.isResetButtonShown {
                    Button("Сбросить") {
                        didResetButtonTapped()
                    }
                    .lineLimit(1)
                    .padding([.top, .trailing])
                }
            }
            filter.content
                .padding([.leading, .trailing])
            applyButton
        }
        .background(Color.white)
    }

    // MARK: - UI

    var applyButton: some View {
        Group {
            Text("Применить")
                .foregroundColor(.white)
                .frame(minWidth: .zero,
                       idealWidth: .infinity,
                       maxWidth: .infinity,
                       minHeight: 0,
                       idealHeight: 0,
                       maxHeight: .applyButtonHeight,
                       alignment: .center)
                .background(Color.gray)
        }
        .padding([.leading, .trailing, .bottom])
        .onTapGesture {
            didApplyButtonTapped()
        }
    }

    // MARK: - Actions

    private func didApplyButtonTapped() {
        finishAction()
    }

    private func didResetButtonTapped() {
    }
}

#if DEBUG
struct FiltersContainer_Previews: PreviewProvider {

    static var previews: some View {
        FilterContainer( filter: FilterView(RecommendationFilter()), finishAction: {
        })
        .previewLayout(.fixed(width: 400, height: 200))
    }
}
#endif

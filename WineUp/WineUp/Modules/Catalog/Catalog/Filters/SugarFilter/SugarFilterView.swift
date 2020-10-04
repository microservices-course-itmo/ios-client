import SwiftUI

struct SugarFilterView: View {
    var items: [SugarFilterItemModel]
    var onItemTap: OnItemTap?
    var body: some View {
        
        VStack {
            VStack(alignment: .trailing, spacing: 5) {
                ForEach(items) { item in
                    SugarFilterItemButton(item: item).frame(minWidth: 60, maxWidth: .infinity)
                    Divider()
                    
                }
            }
        }
    }
    
    typealias OnItemTap = (SugarFilterItemModel) -> Void
    private func itemDidTap(_ item: SugarFilterItemModel) {
        onItemTap?(item)
    }
}

#if DEBUG
struct SugarFilterViewPreviews: PreviewProvider {
    private static let items = [
        SugarFilterItemModel(title: "Сухое"),
        SugarFilterItemModel(title: "Полусухое"),
        SugarFilterItemModel(title: "Полусладкое"),
        SugarFilterItemModel(title: "Сладкое")
    ]
    static var previews: some View {
        return SugarFilterView(items: items, onItemTap: nil)
            .previewLayout(.fixed(width: 400, height: 250))
    }
}
#endif

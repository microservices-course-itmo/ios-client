import SwiftUI

struct ColorFilterView: View {
    var items: [ColorFilterItemModel]
    var onItemTap: OnItemTap?
    var body: some View {
        VStack {
            
            VStack(alignment: .trailing, spacing: 5) {
                ForEach(items) {  item in
                    ColorFilterItemButton(item: item)
                        .frame(minWidth: 60, maxWidth: .infinity)
                    Divider()
                }
            }
        }
    }
    
    typealias OnItemTap = (ColorFilterItemModel) -> Void
    private func itemDidTap(_ item: ColorFilterItemModel) {
        onItemTap?(item)
    }
}

#if DEBUG
struct ColorFilterViewPreviews: PreviewProvider {
    private static let items = [
        ColorFilterItemModel(title: "Белое"),
        ColorFilterItemModel(title: "Красное"),
        ColorFilterItemModel(title: "Розовое")
    ]
    static var previews: some View {
        return ColorFilterView(items: items, onItemTap: nil)
            .previewLayout(.fixed(width: 400, height: 250))
    }
}
#endif

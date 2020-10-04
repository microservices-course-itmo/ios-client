import SwiftUI

struct SugarFilterItemModel: Identifiable {
    var id = UUID()
    var title: String
}

struct SugarFilterItemView: View {

    let item: SugarFilterItemModel
    var isChecked: Bool

    var body: some View {
        VStack(alignment: .trailing) {
            HStack(alignment: .center) { Image(systemName: self.isChecked ? "checkmark.square.fill": "square").foregroundColor(self.isChecked ? Color(red: 158 / 255.0, green: 51 / 255.0, blue: 75 / 255.0) : .black) ; Text(item.title).foregroundColor(.primary)
                .font(.system(size: 13))
            }
        }.frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
    }
}

#if DEBUG
struct SugarFilterItemViewPreview: PreviewProvider {
    private static let item = SugarFilterItemModel(title: "Test")
    static var previews: some View {
        return SugarFilterItemView(item: item, isChecked: false)
            .previewLayout(.fixed(width: 400, height: 250))
    }
}
#endif

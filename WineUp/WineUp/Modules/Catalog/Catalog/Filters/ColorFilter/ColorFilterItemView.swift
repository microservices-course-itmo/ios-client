import SwiftUI

struct ColorFilterItemModel: Identifiable {
    var id = UUID()
    var title: String
}

struct ColorFilterItemView: View {

    let item: ColorFilterItemModel
    var isChecked: Bool

    var body: some View {
        VStack(alignment: .trailing) {
            HStack(alignment: .center) { Image(systemName: self.isChecked ? "checkmark.square.fill": "square").foregroundColor(self.isChecked ? Color(red: 158 / 255.0, green: 51 / 255.0, blue: 75 / 255.0) : .black) ; Text(item.title)  .foregroundColor(.primary).font(.system(size: 13)) }
        }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 20, maxHeight: 20, alignment: .leading)
    }
}

#if DEBUG
struct ColorFilterItemViewPreview: PreviewProvider {
    private static let item = ColorFilterItemModel(title: "Test")
    static var previews: some View {
        return ColorFilterItemView(item: item, isChecked: false)
            .previewLayout(.fixed(width: 400, height: 250))
    }
}
#endif

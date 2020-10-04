import SwiftUI

struct ColorFilterItemButton: View {

    let item: ColorFilterItemModel

    @State var isChecked: Bool = false

    func action () {
        isChecked.toggle()
    }

    var body: some View {
        Button(action: action, label: {
            ColorFilterItemView(item: item, isChecked: self.isChecked).padding()
        })
    }

#if DEBUG
struct ColorFilterItemButtonPreview: PreviewProvider {
    private static let item = ColorFilterItemModel( title: "test")
    static var previews: some View {
        return ColorFilterItemButton(item: item)

            .previewLayout(.fixed(width: 400, height: 250))
    }
}
#endif

}

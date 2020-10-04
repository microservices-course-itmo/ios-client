import SwiftUI

struct SugarFilterItemButton: View {

    let item: SugarFilterItemModel

    @State var isChecked: Bool = false

    func action () {
        isChecked.toggle()
    }

    var body: some View {
        Button(action: action, label: {
            SugarFilterItemView(item: item, isChecked: self.isChecked).padding()
        })
    }

#if DEBUG
struct SugarFilterItemButtonPreview: PreviewProvider {
    private static let item = SugarFilterItemModel( title: "test")
    static var previews: some View {
        return SugarFilterItemButton(item: item)

            .previewLayout(.fixed(width: 400, height: 250))
    }
}
#endif

}

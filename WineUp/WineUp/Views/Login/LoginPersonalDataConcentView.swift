//
//  LoginPersonalDataConcentView.swift
//  WineUp
//
//  Created by Александр Пахомов on 19.10.2020.
//

import SwiftUI

// MARK: - View

struct LoginPersonalDataConcentView: View {

    @State private var doConcent = false

    let onConcent: () -> Void

    var body: some View {
        LoginContainer(title: "Согласитесь)", viewLabel: {
            Toggle("Соглашаюсь с обработкой персональных данных", isOn: $doConcent.onSet(didToggle(doCencent:)))
                .padding()
        }, actionLabel: {
            EmptyView()
        })
    }
}

// MARK: - Helpers

private extension LoginPersonalDataConcentView {
    func didToggle(doCencent: Bool) {
        if doConcent {
            onConcent()
        }
    }
}

// MARK: - Preview

#if DEBUG
struct LoginPersonalDataConcentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginPersonalDataConcentView(onConcent: {})
    }
}
#endif

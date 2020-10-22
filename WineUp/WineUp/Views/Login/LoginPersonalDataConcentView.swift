//
//  LoginPersonalDataConcentView.swift
//  WineUp
//
//  Created by Александр Пахомов on 19.10.2020.
//

import SwiftUI

// MARK: - View

struct LoginPersonalDataConcentView: View {

    let onConcent: () -> Void
    @State private var doConcent = false {
        didSet {
            if doConcent {
                onConcent()
            }
        }
    }

    var body: some View {
        LoginContainer(title: "Согласитесь)", viewLabel: {
            Toggle("Соглашаюсь с обработкой персональных данных", isOn: $doConcent)
                .padding()
        }, actionLabel: {
            EmptyView()
        }
        )
    }
}

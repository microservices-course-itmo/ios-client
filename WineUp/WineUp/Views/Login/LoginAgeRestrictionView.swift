//
//  LoginAgeRestrictionView.swift
//  WineUp
//
//  Created by Александр Пахомов on 14.10.2020.
//

import SwiftUI

// MARK: - View

struct LoginAgeRestrictionView: View {
    var body: some View {
        LoginContainer(title: "Спасибо за честный ответ!", viewLabel: {
            Text("К сожалению, наше приложение содержит информацию, не предназначенную для лиц младше 18 :(")
                .multilineTextAlignment(.center)
                .lineLimit(4)
                .font(.body)
        }, actionLabel: EmptyView.init)
    }
}

// MARK: - Preview

#if DEBUG
struct LoginAgeRestrictionView_Previews: PreviewProvider {
    static var previews: some View {
        LoginAgeRestrictionView()
    }
}
#endif

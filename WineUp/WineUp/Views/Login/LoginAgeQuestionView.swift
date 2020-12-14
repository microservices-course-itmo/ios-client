//
//  LoginAgeQuestionView.swift
//  WineUp
//
//  Created by Александр Пахомов on 19.10.2020.
//

import SwiftUI

// MARK: - View

struct LoginAgeQuestionView: View {

    let onOlderThan18ButtonTap: () -> Void
    let onYoungerThan18ButtonTap: () -> Void

    var body: some View {
        LoginYoNButtonsContainer(
            title: "Добро пожаловать!",
            yesButtonTitle: "Да!",
            noButtonTitle: "Нет",
            onYesButtonTap: onOlderThan18ButtonTap,
            onNoButtonTap: onYoungerThan18ButtonTap,
            label: {
                Text("Вам уже исполнилось 18?")
            }
        )
    }
}

// MARK: - Preview

#if DEBUG
struct LoginAgeRequestView_Previews: PreviewProvider {
    static var previews: some View {
        LoginAgeQuestionView(onOlderThan18ButtonTap: {}, onYoungerThan18ButtonTap: {})
    }
}
#endif

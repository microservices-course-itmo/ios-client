//
//  VerificationCodeView.swift
//  WineUp
//
//  Created by Nikolai Solonenko on 07.10.2020.
//

import SwiftUI

struct VerificationCodeView: View {

    @ObservedObject private var viewModel = VerificationCodeViewModel()

    var body: some View {
            VStack(alignment: .center, spacing: 35, content: {

                //Блок "Введите код"
                VStack(alignment: .center, spacing: 30, content: {
                    Text("Код введен неверно").foregroundColor(.red)
                    Text("Введите код подтверждения").font(.title2)
                })
                //Блок с кодом, кнопками и тайтлом отправить повторно
                VStack(alignment: .center, spacing: 30, content: {
                    // Подблок кода и кнопок
                    VStack(alignment: .center, spacing: -5, content: {
                        //TextField кода
                        TextField("000000", text: $viewModel.code)
                            .multilineTextAlignment(.center)
                            .font(.title)
                        Rectangle()
                            .frame(width: 105, height: 2.0, alignment: .top)
                            .foregroundColor(Color.red)
                        //Кнопка войти
                        Button(action: {}, label: {
                            Text("Войти")
                                .foregroundColor(.red)
                                .padding([.leading, .trailing], 20)
                                .padding([.top, .bottom], 8)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color.red, lineWidth: 3)
                                )
                        }).padding(.top, 30)
                        //Кнопка отправить повторно
                        Button(action: {}, label: {
                            Text("Отправить повторно")
                                .foregroundColor(.red)
                                .padding([.leading, .trailing], 20)
                                .padding([.top, .bottom], 8)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color.red, lineWidth: 3)
                                )
                        }).padding(.top, 30)
                    }).padding(.top, 10)

                    //Label отпарвить повторно
                    Text("Отправить повторно через 59с").font(.callout)
                    //Кннопка назад
                    Button(action: {}, label: {
                        Text("Назад")
                            .foregroundColor(.red)
                            .padding([.leading, .trailing], 150)
                            .padding([.top, .bottom], 8)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.red, lineWidth: 3)
                            )
                    }).padding(.top, 110)
                })
            }).padding(.top, 80)
        }
    }

#if DEBUG

struct VerificationCodeViewPreviews: PreviewProvider {
    static var previews: some View {
        return VerificationCodeView()
    }
}

#endif

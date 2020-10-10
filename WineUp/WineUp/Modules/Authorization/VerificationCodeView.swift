//
//  VerificationCodeView.swift
//  WineUp
//
//  Created by Nikolai Solonenko on 07.10.2020.
//

import SwiftUI

struct VerificationCodeView: View {

    @State private var code: String = ""

    init() {
        guard let largeFont = UIFont(name: "Georgia-Bold", size: 50) else {
            return
        }
        UINavigationBar.appearance().largeTitleTextAttributes = [.font: largeFont]
    }

    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 35, content: {
                VStack(alignment: .center, spacing: 30, content: {
                    Text("Код введен неверно").foregroundColor(.red)
                    Text("Введите код подтверждения").font(.title2)
                })
                VStack(alignment: .center, spacing: 30, content: {
                    VStack(alignment: .center, spacing: -5, content: {
                        TextField("000000", text: $code)
                            .multilineTextAlignment(.center)
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        Rectangle()
                            .frame(width: 105, height: 2.0, alignment: .top)
                            .foregroundColor(Color.red)
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

                    Text("Отправить повторно через 59с").font(.callout)
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
            .navigationBarTitle(Text("WineUP").font(.subheadline), displayMode: .large)
        }
    }
}

struct VerificationCodeViewPreviews: PreviewProvider {
    static var previews: some View {
        return VerificationCodeView()
    }
}

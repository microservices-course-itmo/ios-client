//
//  PhoneAuthorizationView.swift
//  WineUp
//
//  Created by Влад on 10.10.2020.
//

import SwiftUI

struct PhoneAuthorizationView: View {
    @ObservedObject var phoneNumber = PhoneNumberModel()
    let chColor = Color(red: 158 / 255.0, green: 51 / 255.0, blue: 75 / 255.0)
    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 40, content: {
                Text("Введите номер телефона для авторизации").font(.system(size: 25)).lineLimit(2)
                VStack(alignment: .center, spacing: 0, content: {
                    TextField("+7 (9XX) XXX-XX-XX", text: $phoneNumber.correctNum) .multilineTextAlignment(.leading)
                        .padding(.horizontal, 26.0).font(.system(size: 25))
                    Divider()
                        .frame(width: 330, height: 1.5)
                        .padding(.horizontal, 0.0)
                        .background(chColor)
                })
                VStack(alignment: .center, spacing: 20, content: {
                    Button(action: {}) {
                        HStack {
                            Text("Войти")
                                .fontWeight(.bold)
                                .font(.title2)
                        }
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(chColor)
                        .cornerRadius(10)
                        .padding(.horizontal, 20)
                    }
                    Button(action: {}) {
                        HStack {
                            Text("Продолжить без авторизации")
                                .font(.title3)
                                .fontWeight(.regular)
                                .multilineTextAlignment(.center)
                                .lineLimit(2)
                                .padding(.horizontal, -5.0)
                        }
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.black)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(chColor, lineWidth: 2)
                        )
                        .padding(.horizontal, 20)
                    }
                })
            }).padding()
            .navigationBarTitle("WineUp")
        }
    }
}

#if DEBUG
struct PhoneView_Previews: PreviewProvider {
    static var previews: some View {
        PhoneAuthorizationView(phoneNumber: PhoneNumberModel())
    }
}
#endif

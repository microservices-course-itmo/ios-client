//
//  PhoneAuthorizationView.swift
//  WineUp
//
//  Created by Влад on 10.10.2020.
//

import SwiftUI

struct PhoneAuthorizationView: View {

    @ObservedObject var phoneNumber = PhoneNumberViewModel()
    let themeColor = Color(red: 158 / 255.0, green: 51 / 255.0, blue: 75 / 255.0)
    
    var body: some View {
        VStack(alignment: .center, spacing: 40, content: {
            Text("Введите номер телефона для авторизации")
                .font(.system(size: 25))
                .lineLimit(/*@START_MENU_TOKEN@*/2/*@END_MENU_TOKEN@*/)
            VStack(alignment: .center, spacing: 0, content: {
                TextField("+7 (9XX) XXX-XX-XX", text: $phoneNumber.correctNum) .multilineTextAlignment(.leading)
                    .padding(.horizontal, 26.0)
                    .font(.system(size: 25))
                Divider()
                    .frame(width: 330, height: 1.5)
                    .padding(.horizontal, 0.0)
                    .background(themeColor)
            })
            VStack(alignment: .center, spacing: 20, content: {
                Button(action: {}) {
                    Text("Войти")
                        .fontWeight(.bold)
                        .font(.title2)
                        .frame(width: 330)
                        .padding()
                        .foregroundColor(.white)
                        .background(themeColor)
                        .cornerRadius(10)
                }
                Button(action: {}) {
                    Text("Продолжить без авторизации")
                        .font(.title3)
                        .fontWeight(.regular)
                        .multilineTextAlignment(.center)
                        .frame(width: 330)
                        .padding()
                        .foregroundColor(.black)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(themeColor, lineWidth: 2))
                }
            })
        }).padding()
    }
}

#if DEBUG
struct PhoneView_Previews: PreviewProvider {
    static var previews: some View {
        PhoneAuthorizationView(phoneNumber: PhoneNumberViewModel())
    }
}
#endif

//
//  AgeNotConfirmedView.swift
//  WineUp
//
//  Created by George on 11.10.2020.
//

import SwiftUI

struct AgeNotConfirmedView: View {

    @State var isBack = false

    var body: some View {
        VStack {
            HStack {
                Text("WineUp")
                    .font(.system(size: 50))
                    .fontWeight(.thin)
                    .foregroundColor(Color(UIColor.label))
                Spacer()
            }
            .padding()

            Spacer()

            HStack {
                Text("Спасибо за честный ответ!")
                    .font(.title2)
                    .foregroundColor(Color(UIColor.label))
                    .padding(.bottom, 20)
                Spacer()
            }

            Text("К сожалению, приложение содержит информацию, не предназначенную для лиц младше 18 :(")
                .font(.title2)
                .foregroundColor(Color(UIColor.label))
                .padding(.bottom, 26)

            Button(action: {
                self.isBack.toggle()
            }) {
                ZStack {
                    Text("Назад").foregroundColor(.white)
                }
                .frame(width: 70, height: 40, alignment: .center)
                .background(Color.red)
                .cornerRadius(3)
            }

            Spacer()
        }
    }
}

struct AgeNotConfirmedView_Previews: PreviewProvider {
    static var previews: some View {
        AgeNotConfirmedView()
    }
}

//
//  AgeAgreementView.swift
//  WineUp
//
//  Created by George on 11.10.2020.
//

import SwiftUI

struct AgeAgreementView: View {

    @State var isYes = false
    @State var isNo = false

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

            VStack {
                Text("Добро пожаловать!")
                    .font(.title2)
                    .foregroundColor(Color(UIColor.label))

                Spacer()

                Text("Вам уже исполнилось 18?")
                    .font(.title2)
                    .bold()
                    .foregroundColor(Color(UIColor.label))
            }
            .frame(height: 100, alignment: .center)

            Spacer()

            HStack {
                Button(action: {
                    self.isYes.toggle()
                }) {
                    ZStack {
                        Text("Да!")
                            .foregroundColor(.white)
                    }
                    .frame(width: 70, height: 40, alignment: .center)
                    .background(Color.red)
                    .cornerRadius(3)
                }

                Button(action: {
                    self.isNo.toggle()
                }) {
                    Text("Нет")
                        .foregroundColor(.red)
                        .frame(width: 70, height: 40, alignment: .center)
                }
            }
            .padding(.bottom, 26)
        }

        Spacer()
    }
}

struct AgeAgreementView_Previews: PreviewProvider {
    static var previews: some View {
        AgeAgreementView()
    }
}

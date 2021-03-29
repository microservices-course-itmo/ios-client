//
//  Error503Screen.swift
//  WineUp
//
//  Created by Dmitry Rebrik on 29.03.2021.
//

import SwiftUI

struct Error503Screen: View {

    var body: some View {
        ZStack {
            VStack(spacing: 7) {
                Text("Ошибка")
                    .font(.system(size: 25))
                    .fontWeight(.medium)
                Text("503")
                    .font(.system(size: 64))
                    .fontWeight(.bold)
                    .overlay(
                        Image("errorIcon")
                                .offset(x: 70, y: -30)
                    )
                Spacer().frame(width: 0, height: 24)
                Text("В настоящее время сервер недоступен\nиз-за технического обслуживания")
                    .font(.system(size: 16))
            }
            Image("503")
        }
    }
}

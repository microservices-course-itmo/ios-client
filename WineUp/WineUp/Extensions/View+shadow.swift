//
//  View+shadow.swift
//  WineUp
//
//  Created by Александр Пахомов on 23.10.2020.
//

import SwiftUI

extension View {
    func faintShadow() -> some View {
        shadow(color: Color.black.opacity(0.1), radius: 32, x: 0, y: 0)
    }
}

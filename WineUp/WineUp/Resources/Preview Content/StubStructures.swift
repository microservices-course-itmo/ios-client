//
//  StubStructures.swift
//  WineUp
//
//  Created by Александр Пахомов on 11.10.2020.
//

import SwiftUI

#if DEBUG

/// SImple implementation of `RadioButtonItem` protocol
struct StubRadioButtonItem: RadioButtonItem {
    var text: String

    var textRepresentation: LocalizedStringKey {
        return LocalizedStringKey(text)
    }

    var id: Int {
        text.hash
    }
}

#endif

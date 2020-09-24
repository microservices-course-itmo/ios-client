//
//  ApplicationRootView.swift
//  WineUp
//
//  Created by Александр Пахомов on 22.09.2020.
//

import SwiftUI

struct ApplicationRootView: View {
    @ObservedObject private var viewModel = ApplicationRootViewModel()

    var body: some View {
        ApplicationMenuView()
    }
}

struct ApplicationRootView_Previews: PreviewProvider {
    static var previews: some View {
        ApplicationRootView()
    }
}

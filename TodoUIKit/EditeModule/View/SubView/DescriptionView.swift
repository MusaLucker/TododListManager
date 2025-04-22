//
//  DescriptionView.swift
//  TodoUIKit
//
//  Created by MusaIstema on 17.04.2025.
//

import SwiftUI

struct DescriptionView: View {
    @Binding var text:String
    var body: some View {
        TextEditor(text:$text)
            .font(.title3)
            .foregroundStyle(.white)
            .fontWeight(.regular)
            .scrollContentBackground(.hidden)
            .autocorrectionDisabled()
            .background(.black)
            .contentMargins(.top,12)
            .contentMargins(.bottom,15)
            .contentMargins(.leading,6)
            .contentMargins(.trailing,15)
            .multilineTextAlignment(.leading)
    }
}



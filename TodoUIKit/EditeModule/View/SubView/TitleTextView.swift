//
//  TitleTextView.swift
//  TodoUIKit
//
//  Created by MusaIstema on 17.04.2025.
//

import SwiftUI

struct TitleTextFieldView: View {
    @Binding var text:String
    var placeholder:String = ""
    @State private var inputText:String = ""
    var body: some View {
        TextField(text: $text, axis: .horizontal) {
            Text(placeholder)
                .foregroundColor(.gray.opacity(0.8))
        }
        .font(.title)
        .foregroundColor(.white)
        .frame(maxWidth: .infinity)
        .frame(height: 52)
        .padding(.leading,10)
        .padding(.trailing,30)
        .background(.black)
        .onChange(of: text) { oldValue, newValue in
            if newValue.count <= 20 {
                inputText = newValue
            }else {
                text = inputText
            }
        }
    }
}

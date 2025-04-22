//
//  SearchFieldView.swift
//  TodoUIKit
//
//  Created by MusaIstema on 17.04.2025.
//

import SwiftUI
struct SearchTextFieldView: View {
    //MARK: - Properties
    @State private var  inputText = ""
    @Binding var search:String
    //MARK: - Body
    var body: some View {
        TextField(text: $search, axis: .horizontal) {
            Text("Поиск")
                .foregroundStyle(.white.opacity(0.8))
        }
        .font(.title3)
        .foregroundStyle(.white)
        .frame(maxWidth: .infinity)
        .frame(height: 48)
        .padding(.leading,40)
        .padding(.trailing,40)
        .background(.white.opacity(0.3))
        .autocorrectionDisabled()
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .overlay(alignment:Alignment(horizontal: .trailing, vertical: .center)) {
            Button {
                search = ""
            } label: {
                Image(systemName: "mic.fill")
                    .font(.title2)
                    .foregroundStyle(.white.opacity(0.8))
                    .padding(.trailing,15)
                
            }
        }
        .overlay(alignment:Alignment(horizontal: .leading, vertical: .center)) {
            Image(systemName: "magnifyingglass")
                .font(.title2)
                .foregroundStyle(.white.opacity(0.8))
                .padding(.leading,5)
        }
        .onChange(of:search) { oldValue, newValue in
            if newValue.count <= 35 {
                inputText = newValue
            }else {
                search = inputText
            }
        }
    }
}


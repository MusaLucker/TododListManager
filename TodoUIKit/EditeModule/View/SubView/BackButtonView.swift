//
//  BackButtonView.swift
//  TodoUIKit
//
//  Created by MusaIstema on 17.04.2025.
//

import SwiftUI
struct BackButtonView: View {
    var completion:()->Void
    var body: some View {
        Button {
           completion()
        } label: {
            HStack(spacing:5) {
                Image(systemName: "chevron.left")
                    .font(.title)
                Text("Назад")
                    .font(.title2)
            }
            .foregroundStyle(.yellow)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    BackButtonView(completion: {})
}

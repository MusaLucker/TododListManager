//
//  EditViewContent.swift
//  TodoUIKit
//
//  Created by MusaIstema on 17.04.2025.
//

import SwiftUI

struct EditViewContent: View {
    //MARK: - Properties
    @State private var title:String = ""
    @State private var desciption:String = ""
    @State private var date:String = ""
    @State private var id:String = ""
    init(id:String, title: String, desciption: String, date:String, delegate: EditViewDelegate) {
        self._title = .init(initialValue: title)
        self._desciption = .init(initialValue: desciption)
        self._date = .init(initialValue:date)
        self._id = .init(initialValue: id)
        self.delegate = delegate
    }
    var delegate:EditViewDelegate
    //MARK: - Body
    var body: some View {
        VStack(alignment:.leading) {
            HStack() {
                BackButtonView {
                    DataBaseManager.shared.updateTodoItem(id:id, title: title, descript: desciption)
                    delegate.close()
                }
                Spacer()
            }
            .padding(.vertical,16)
            TitleTextFieldView(text: $title)
            Text(date)
                .font(.title3)
                .foregroundStyle(.white.opacity(0.5))
                .padding(.horizontal,16)
            DescriptionView(text: $desciption)
            Spacer()
        }
        .padding(.horizontal,8)
        .background(.black)
    }
}


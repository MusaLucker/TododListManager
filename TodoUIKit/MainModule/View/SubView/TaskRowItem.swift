//
//  TaskRowItem.swift
//  TodoUIKit
//
//  Created by MusaIstema on 17.04.2025.
//

import SwiftUI

struct TaskRowView: View,Identifiable {
    //MARK: - Property
    let id:UUID = UUID()
    let todoId:String
    let title:String
    let description:String
    let time:Date
    @State var isChecked:Bool = false
    @State private var isStriked:Bool = false
    var delegate:AddViewDelegate
    let item:TodoItem
    init(todoId: String, title: String, description: String, time: Date,completed: Bool,delegate:AddViewDelegate,item:TodoItem) {
        self.todoId = todoId
        self.title = title
        self.description = description
        self.time = time
        self._isChecked = .init(initialValue: completed)
        self.delegate = delegate
        self.item = item
    }
    //MARK: - Body
    var body: some View {
        VStack(alignment:.leading) {
            HStack(alignment:.top) {
                Image(systemName: isChecked ? "checkmark.circle" : "circle")
                            .font(.title)
                            .fontWeight(.thin)
                            .foregroundStyle(isChecked ? .yellow : .white.opacity(0.8))
                            .onTapGesture(count:1) {
                                withAnimation {
                                    isChecked.toggle()
                                    isStriked.toggle()
                                }
                                DataBaseManager.shared.toggleComleted(id: todoId)
                            }
                VStack(alignment:.leading,spacing:5) {
                    Text(title)
                        .strikethrough(isStriked ? true : false, color: Color.gray.opacity(0.8))
                        .foregroundStyle(isChecked ? .gray.opacity(0.8) : .white )
                        .font(.title2)
                    Text(description)
                        .foregroundStyle(isChecked ? .gray.opacity(0.8) : .white )
                        .font(.title3)
                        .lineLimit(2)
                    Text(time.dateIntoString())
                        .font(.title3)
                        .foregroundStyle(.white.opacity(0.5))
                }
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .background(.black)
            //MARK: - Context Menu
            .contextMenu {
                Button {
                    delegate.showEdit(id:todoId,title:title,description:description,time:time)
                } label: {
                    Label("Редактировать", systemImage: "square.and.pencil")
                }
                
                
                Button {
                   /// there's no action for this button
                } label: {
                    Label("Поделиться", systemImage: "square.and.arrow.up")

                }
                Button(role: .destructive) {
                    delegate.deleteTodoItem(title: title)
                } label: {
                    Label("Удалить", systemImage: "trash")
                }

            }
        }
        .background(.black)
    }
}

//#Preview {
//    TaskRowView(title:"Book the read", description: "readed the booksdsfdsf sdfsd fdsf sdfsd fsd fsd fsdf sdfdsfds sdf sdf sdfsd fsd fsd fsd fsdf")
//}

//
//  MainViewContent.swift
//  TodoUIKit
//
//  Created by MusaIstema on 17.04.2025.
//

import SwiftUI

struct MainViewContent: View {
    @State private var title = ""
    @State private var description = ""
    @State private var items:[TodoItem] = []
    @State private var search:String = ""
    @State private var isCheckedTrue:Bool = false
    @State private var isPresented:Bool = false
    @Environment (\.dismiss) var dismiss
    var delegate:AddViewDelegate
    init(todoItems:[TodoItem],delegate:AddViewDelegate) {
        self._items = .init(initialValue:todoItems)
        UINavigationBar.appearance().barStyle = .black
        self.delegate = delegate
    }
    var body: some View {
        NavigationStack {
            VStack(alignment:.leading) {
                ScrollView {
                    SearchTextFieldView(search: $search)
                        .padding(.vertical,10)
                    
                    ForEach(items) { item in
                        if let title = item.title {
                            if !search.isEmpty && title.lowercased().contains(search.lowercased()) {
                                
                                TaskRowView(todoId: item.id ?? "", title: title, description: item.descript ?? "", time:item.date ?? Date(),completed:item.completed, delegate:delegate,item:item)
                                
                                Divider()
                                    .background(.white.opacity(0.8))
                            } else if search.isEmpty {
                                
                                TaskRowView(todoId: item.id ?? "", title: title, description: item.descript ?? "", time:item.date ?? Date(),completed:item.completed, delegate:delegate,item:item)
                                
                                Divider()
                                    .background(.white.opacity(0.8))
                            }
                        }
                    
                        
                    }
                }
                .background(Color.black)
                .contentMargins(.leading,10)
            }
            .background(.black)
            .navigationTitle("Задачи")
            .navigationBarTitleDisplayMode(.large)
            .toolbarBackground(.automatic, for: .bottomBar)
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    HStack {
                        Spacer()
                        Text(items.count.convertIntoString())
                            .font(.system(size: 18))
                            .foregroundStyle(.white)
                        Spacer()
                        Button {
                            isPresented.toggle()
                            //self.delegate.createTodoItem()
                        } label:{
                            Image(systemName: "square.and.pencil")
                                .font(.title2)
                                .foregroundStyle(.yellow)
                        }
                        .alert("Добавить новую задачу",isPresented: $isPresented) {
                            TextField("Введите заголовок",text:$title)
                            TextField("Введите описание",text:$description)
                            Button {
                                if !title.isEmpty {
                                    delegate.createTodoItem(title: title, description: description)
                                }
                            } label: {
                                Text("Добавить")
                            }

                            Button(role: .cancel) {
                                //
                            } label: {
                                Text("Отмена")
                            }
                            

                        }
                        
                        .buttonStyle(PlainButtonStyle())
                    }
                }
            }

        }
        
    }
}

//#Preview {
//    MainViewContent(todoItems: [], delegate: <#any AddViewDelegate#>)
//}

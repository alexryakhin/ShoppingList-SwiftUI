//
//  ContentView.swift
//  ShoppingList-SwiftUI
//
//  Created by Alexander Bonney on 8/5/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var vm = ShoppingListViewModel()
    
    @State private var text = ""
    @State private var showingAlert: Bool = false
    @State private var searchTerm = ""
    
    var body: some View {
        ZStack {
            NavigationView {
                List {
                    ForEach(searchTerm.isEmpty
                            ? vm.products
                            : vm.products.filter({ product in
                        product.name.lowercased().starts(with: searchTerm.lowercased())
                    })) { product in
                        HStack {
                            Image(systemName: product.checkmark ? "checkmark.circle" : "circle")
                                .foregroundColor(product.checkmark ? .blue : .black)
                            Text(product.name)
                            Color.white.opacity(0.01)
                        }
                        .onTapGesture {
                            if let index = vm.products.firstIndex(where: {
                                $0.id == product.id
                            }) {
                                vm.products[index].checkmark.toggle()
                            }
                        }
                    }.onDelete(perform: vm.remove)
                }
                .navigationTitle("Shopping List")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            withAnimation() {
                                showingAlert = true
                            }
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        EditButton()
                    }
                }
            }.searchable(text: $searchTerm)
            if showingAlert {
                AlertWithTextField(title: "Add new product", text: $text, onCommit: {
                    withAnimation() {
                        if !text.isEmpty {
                            showingAlert = false
                            let newProduct = Product(name: text)
                            vm.products.append(newProduct)
                            vm.save()
                            text = ""
                        }
                    }
                }, onCancel: {
                    withAnimation() {
                        showingAlert = false
                    }
                })
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



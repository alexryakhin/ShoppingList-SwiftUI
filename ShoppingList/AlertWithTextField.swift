//
//  AlertWithTextField.swift
//  AlertWithTextField
//
//  Created by Alexander Bonney on 8/5/21.
//

import SwiftUI

struct AlertWithTextField: View {
    var title: String
    @Binding var text: String
    var onCommit: () -> Void
    var onCancel: () -> Void
    
    @FocusState private var isFocused: Bool
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.1).ignoresSafeArea()
            VStack(spacing: 15) {
                Text(title).font(.headline)
                TextField("Input", text: $text, onCommit: {
                    isFocused = false
                    onCommit()
                })
                    .padding(10)
                    .background(Color.secondary.opacity(0.2).cornerRadius(10))
                    .focused($isFocused)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            isFocused = true
                        }
                    }
                HStack {
                    Button {
                        onCancel()
                    } label: {
                        Text("Cancel").foregroundColor(.white).padding(10).frame(maxWidth: .infinity).background(Color.red).cornerRadius(10)
                    }
                    Button {
                        onCommit()
                    } label: {
                        Text("OK").foregroundColor(.white).padding(10).frame(maxWidth: .infinity).background(text.isEmpty ? Color.secondary : Color.green).cornerRadius(10)
                    }.disabled(text.isEmpty)
                }

            }.padding().background(Color.white).clipShape(RoundedRectangle(cornerRadius: 15)).frame(width: 260, height: 100)
        }
    }
}



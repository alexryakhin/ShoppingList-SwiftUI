//
//  ShoppingListViewModel.swift
//  ShoppingListViewModel
//
//  Created by Alexander Bonney on 8/5/21.
//

import SwiftUI

class ShoppingListViewModel: ObservableObject {
    
    @Published var products: [Product] = []
    
    func remove(indexSet: IndexSet) {
        products.remove(atOffsets: indexSet)
        save()
    }
    
    init() {
        load()
    }
    
    func load() {
        if let products = UserDefaults.standard.data(forKey: "products") {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([Product].self, from: products) {
                self.products = decoded
                return
            }
        }
        
        self.products = []
    }
    
    func save() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(products) {
            UserDefaults.standard.set(encoded, forKey: "products")
        }
    }
    
}

//
//  Product.swift
//  Product
//
//  Created by Alexander Bonney on 8/5/21.
//

import SwiftUI

struct Product: Identifiable, Codable {
    var id = UUID()
    var name: String
    var checkmark: Bool = false
}

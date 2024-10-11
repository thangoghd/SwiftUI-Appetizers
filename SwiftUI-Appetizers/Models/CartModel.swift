//
//  CartModel.swift
//  SwiftUI-Appetizers
//
//  Created by Ha Viet Thang on 11/10/24.
//

import Foundation

struct CartItem: Identifiable {
    let id: UUID
    let appetizer: AppetizersModel
    var quantity: Int
    var note: String = ""
}

class CartModel: ObservableObject {
    @Published var items: [CartItem] = []

    var total: Double {
        items.reduce(0) { $0 + $1.appetizer.price * Double($1.quantity) }
    }
    
    func addItem(_ appetizer: AppetizersModel, quantity: Int) {
        if let index = items.firstIndex(where: { $0.appetizer.id == appetizer.id }) {
            items[index].quantity += quantity
        } else {
            let newItem = CartItem(id: UUID(), appetizer: appetizer, quantity: quantity)
            items.append(newItem)
        }
        print(items)
    }
    
    func removeItem(_ item: CartItem) {
        items.removeAll { $0.id == item.id }
    }
    
    func updateQuantity(for item: CartItem, quantity: Int) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index].quantity = quantity
        }
    }
    
    func clearCart() {
        items.removeAll()
    }
}

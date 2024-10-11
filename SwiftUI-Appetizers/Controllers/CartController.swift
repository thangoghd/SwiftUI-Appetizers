//
//  CartController.swift
//  SwiftUI-Appetizers
//
//  Created by Ha Viet Thang on 11/10/24.
//

import Foundation

class CartController: ObservableObject {
    @Published var cart = CartModel()
    
    func addToCart(_ appetizer: AppetizersModel, quantity: Int) {
        if let index = cart.items.firstIndex(where: { $0.appetizer.id == appetizer.id }) {
            cart.items[index].quantity += quantity
        } else {
            let newItem = CartItem(id: UUID(), appetizer: appetizer, quantity: quantity)
            cart.items.append(newItem)
        }
        objectWillChange.send()
    }
    
    func removeFromCart(_ item: CartItem) {
        cart.items.removeAll { $0.id == item.id }
        objectWillChange.send()
    }
    
    func updateQuantity(for item: CartItem, quantity: Int) {
        cart.updateQuantity(for: item, quantity: quantity)
    }
    
    func clearCart() {
        cart.clearCart()
    }
    
    var totalItems: Int {
        cart.items.reduce(0) { $0 + $1.quantity }
    }
    
    var totalPrice: Double {
        cart.total
    }
    
    func updateItem(_ item: CartItem, newQuantity: Int, newNote: String) {
        if let index = cart.items.firstIndex(where: { $0.id == item.id }) {
            cart.items[index].quantity = newQuantity
            cart.items[index].note = newNote
            objectWillChange.send()
        }
    }
}


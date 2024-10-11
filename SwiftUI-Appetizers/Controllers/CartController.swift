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
        cart.addItem(appetizer, quantity: quantity)
    }
    
    func removeFromCart(_ item: CartItem) {
        cart.removeItem(item)
    }
    
    func updateQuantity(for item: CartItem, quantity: Int) {
        cart.updateQuantity(for: item, quantity: quantity)
    }
    
    func clearCart() {
        cart.clearCart()
    }
    
    var totalItems: Int {
//        cart.items.reduce(0) { $0 + $1.quantity }
        cart.items.count
    }
    
    var totalPrice: Double {
        cart.total
    }
}


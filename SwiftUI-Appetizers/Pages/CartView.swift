//
//  CartView.swift
//  SwiftUI-Appetizers
//
//  Created by Ha Viet Thang on 4/10/24.
//

import SwiftUI

struct CartView: View {
    @ObservedObject var cartController: CartController
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(cartController.cart.items) { item in
                        HStack {
                            Text(item.appetizer.name)
                            Spacer()
                            Text("x\(item.quantity)")
                            Text("$\(item.appetizer.price * Double(item.quantity), specifier: "%.2f")")
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
                Section {
                    HStack {
                        Text("Total:")
                        Spacer()
                        Text("$\(cartController.totalPrice, specifier: "%.2f")")
                    }
                    .font(.headline)
                    .padding(EdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20))
                }
            }
            .navigationTitle("Cart")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Clear") {
                        cartController.clearCart()
                    }
                }
            }
            .onAppear {
                print("CartView appeared. Items in cart: \(cartController.cart.items.count)")
            }
        }
    }
    
    func deleteItems(at offsets: IndexSet) {
        for index in offsets {
            let item = cartController.cart.items[index]
            cartController.removeFromCart(item)
        }
    }
}


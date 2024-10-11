//
//  CartView.swift
//  SwiftUI-Appetizers
//
//  Created by Ha Viet Thang on 4/10/24.
//

import SwiftUI

struct CartView: View {
    @EnvironmentObject var cartController: CartController
    @State private var editingItem: CartItem?
    @State private var refreshID = UUID()

    var body: some View {
        NavigationView {
            Group {
                if cartController.cart.items.isEmpty {
                    VStack {
                        Image("emptyCartImage")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 200, height: 200)
                        Text("Your cart is empty")
                            .font(.headline)
                            .foregroundColor(.secondary)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    VStack {
                        List {
                            ForEach(cartController.cart.items) { item in
                                HStack {
                                    Text(item.appetizer.name)
                                    Spacer()
                                    Text("x\(item.quantity)")
                                    Text("$\(item.appetizer.price * Double(item.quantity), specifier: "%.2f")")
                                }
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    editingItem = item
                                }
                            }
                            .onDelete(perform: deleteItems)
                        }
                        
                        Spacer()
                        
                        VStack {
                            //Divider()
                            HStack {
                                Text("Total:")
                                Spacer()
                                Text("$\(cartController.totalPrice, specifier: "%.2f")")
                            }
                            .font(.headline)
                            .padding()
                        }
                    }
                }
            }
            .id(refreshID)
            .navigationTitle("Cart")
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    Button("Clear") {
//                        cartController.clearCart()
//                    }
//                }
//            }
        }
        .sheet(item: $editingItem) { item in
            EditAppetizerCartView(item: item) {
                self.refreshID = UUID()
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



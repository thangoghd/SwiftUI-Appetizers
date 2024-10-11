//
//  EditAppetizerCartView.swift
//  SwiftUI-Appetizers
//
//  Created by Ha Viet Thang on 11/10/24.
//

import SwiftUI

struct EditAppetizerCartView: View {
    @EnvironmentObject var cartController: CartController
    @Environment(\.dismiss) var dismiss
    let item: CartItem
    @State private var quantity: Int
    @State private var note: String = ""
    var onUpdate: () -> Void

    init(item: CartItem, onUpdate: @escaping () -> Void) {
        self.item = item
        self._quantity = State(initialValue: item.quantity)
        self._note = State(initialValue: item.note)
        self.onUpdate = onUpdate
    }

    var body: some View {
        VStack(spacing: 0) {
            ZStack(alignment: .top) {
                AsyncImage(url: URL(string: AppConstants.BASE_URL + AppConstants.UPLOAD_URL + item.appetizer.img)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 200)
                        .clipped()
                } placeholder: {
                    Color.gray
                        .frame(height: 200)
                }
                
                HStack {
                    Button(action: {
                        dismiss()
                    }) {
                        Text("Cancel")
                            .fontWeight(.bold)
                            .padding(8)
                            .background(Color.black.opacity(0.6))
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        cartController.updateItem(item, newQuantity: quantity, newNote: note)
                        onUpdate()
                        dismiss()
                    }) {
                        Text("Save")
                            .fontWeight(.bold)
                            .padding(8)
                            .background(Color.black.opacity(0.6))
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
                .padding()
            }
            
            Form {
                Text(item.appetizer.name)
                Section(header: Text("Quantity")) {
                    Stepper(value: $quantity, in: 1...20) {
                        Text("\(quantity)")
                    }
                }

                Section(header: Text("Note")) {
                    TextField("Add a note for the restaurant", text: $note)
                }
            }
        }
        .navigationBarHidden(true)
        .edgesIgnoringSafeArea(.top)
    }
}



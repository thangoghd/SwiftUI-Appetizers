//
//  ContentView.swift
//  SwiftUI-Appetizers
//
//  Created by Ha Viet Thang on 25/9/24.
//

import SwiftUI

struct AppetizerTabView: View {
    var body: some View {
        TabView{
            Tab("Home", systemImage: "house") {
                AppetizerListView()
            }

            Tab("Cart", systemImage: "cart") {
                CartView()
            }

            Tab("Account", systemImage: "person") {
                AccountView()
            }
        }.tint(Color.mainColor)
    }
}

struct AppetizerTabView_Previews: PreviewProvider{
    static var previews: some View{
        AppetizerTabView()
    }
}

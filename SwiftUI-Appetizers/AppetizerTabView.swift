//
//  ContentView.swift
//  SwiftUI-Appetizers
//
//  Created by Ha Viet Thang on 25/9/24.
//

import SwiftUI

struct AppetizerTabView: View {
    @StateObject private var cartController = CartController()

    var body: some View {
        TabView {
            AppetizerListView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }

            HistotyBillView()
                .tabItem {
                    Label("History Bill", systemImage: "clock.arrow.trianglehead.counterclockwise.rotate.90")
                }

            AccountView()
                .tabItem {
                    Label("Account", systemImage: "person")
                }
        }
        .tint(Color.mainColor)
        .environmentObject(cartController)
    }
}

struct AppetizerTabView_Previews: PreviewProvider{
    static var previews: some View{
        AppetizerTabView()
    }
}

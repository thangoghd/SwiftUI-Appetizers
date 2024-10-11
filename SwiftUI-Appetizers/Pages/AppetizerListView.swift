//
//  AppetizerListView.swift
//  SwiftUI-Appetizers
//
//  Created by Ha Viet Thang on 25/9/24.
//

import SwiftUI

struct AppetizerListView: View {
    @StateObject private var viewModel = AppetizerListViewModel()
    @StateObject private var controller = AppetizerController()
    @StateObject private var cartController = CartController()
    @State private var showingCart = false

    var body: some View {
        ZStack {
            NavigationStack {
                List(viewModel.appertizers) { appetizerItem in
                    HStack {
                        AsyncImage(url: URL(string: AppConstants.BASE_URL + AppConstants.UPLOAD_URL + appetizerItem.img)) { image in
                            image.resizable().aspectRatio(contentMode: .fill)
                        } placeholder: {
                            ProgressView()
                        }.frame(width: 100, height: 100).clipShape(.rect(cornerRadius: 8))
                        VStack(alignment: .leading, spacing: 5) {
                            Text(appetizerItem.name).font(.title2).fontWeight(.medium)
                            Text("$ \(appetizerItem.price, specifier: "%.2f")").foregroundStyle(.secondary).fontWeight(.semibold)
                        }.padding(.leading)
                    }
                    .onTapGesture {
                        viewModel.selectedAppetizer = appetizerItem
                        viewModel.isShowingDetail = true
                        withAnimation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0)) {
                            viewModel.isAnimation = true
                        }
                    }
                }
                .navigationTitle("Appetizers")
                .disabled(viewModel.isShowingDetail)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            showingCart = true
                        }) {
                            ZStack(alignment: .topLeading) {
                                Image(systemName: "cart")
                                    .foregroundColor(.primary)
                                
                                if cartController.totalItems > 0 {
                                    Text("\(cartController.totalItems)")
                                        .font(.caption2).bold()
                                        .foregroundColor(.white)
                                        .frame(width: 20, height: 20)
                                        .background(Color.red)
                                        .clipShape(Circle())
                                        .offset(x: -10, y: -10)
                                }
                            }
                        }
                    }
                }
            }
            .onAppear {
                viewModel.getAppetizers()
            }
            .blur(radius: viewModel.isShowingDetail ? 20 : 0)
            
            if viewModel.isShowingDetail {
                ZStack {
                    Color.white.opacity(0.4)
                        .ignoresSafeArea()
                        .onTapGesture {
                            withAnimation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0)) {
                                viewModel.isAnimation = false
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                viewModel.isShowingDetail = false
                            }
                        }

                    AppetizerDetailView(
                        appetizer: viewModel.selectedAppetizer!,
                        controller: controller,
                        cartController: cartController,
                        isShowing: $viewModel.isShowingDetail,
                        isAnimation: $viewModel.isAnimation
                    )
                    .scaleEffect(viewModel.isAnimation ? 1 : 0.5)
                    .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0), value: viewModel.isAnimation)
                }
            }
            
            if viewModel.isLoading {
                LoadingView()
            }
        }
        .alert(item: $viewModel.alertItem) { alertItem in
            Alert(
                title: Text(alertItem.title),
                message: Text(alertItem.message),
                dismissButton: .default(Text(alertItem.primaryButtonTitle))
            )
        }
        .sheet(isPresented: $showingCart) {
            CartView(cartController: cartController)
        }
    }
}

#Preview {
    AppetizerListView()
}

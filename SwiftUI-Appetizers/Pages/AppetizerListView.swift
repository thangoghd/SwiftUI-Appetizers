//
//  AppetizerListView.swift
//  SwiftUI-Appetizers
//
//  Created by Ha Viet Thang on 25/9/24.
//

import SwiftUI

struct AppetizerListView: View {
    @State private var showAlert = false
    @StateObject var viewModel = AppetizerListViewModel()


    var body: some View {
        ZStack{
            NavigationView {
                List(viewModel.appertizers){
                    appetizerItem in
                    HStack{
                        AsyncImage(url: URL(string: AppConstants.BASE_URL + AppConstants.UPLOAD_URL + appetizerItem.img)){ image in
                            image.resizable().aspectRatio(contentMode: .fill)
                        } placeholder: {
                            ProgressView()
                        }.frame(width: 100, height: 100).clipShape(.rect(cornerRadius: 8))
                        VStack(alignment: .leading, spacing: 5){
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
                }.navigationTitle("Appetizers")
                    .disabled(viewModel.isShowingDetail)
            }
            .onAppear{
                viewModel.getAppetizers()
            }.blur(radius: viewModel.isShowingDetail ? 20 : 0)
            if viewModel.isShowingDetail{
                ZStack {
                    // Background tap to close
                    Color.white.opacity(0.4) // Màu nền mờ
                        .ignoresSafeArea()
                        .onTapGesture {
                            // Hoạt ảnh đóng khi nhấn bên ngoài AppetizerDetailView
                            withAnimation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0)) {
                                viewModel.isAnimation = false
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                viewModel.isShowingDetail = false
                            }
                        }

                    // AppetizerDetailView
                    AppetizerDetailView(appetizer: viewModel.selectedAppetizer!, isShowing: $viewModel.isShowingDetail, isAnimation: $viewModel.isAnimation)
                        .scaleEffect(viewModel.isAnimation ? 1 : 0.5)
                        .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0), value: viewModel.isAnimation)
                }
            }
            
            if viewModel.isLoading{
                LoadingView()
            }

        }.alert(item: $viewModel.alertItem) { alertItem in
            Alert(
                title: Text(alertItem.title),
                message: Text(alertItem.message),
                dismissButton: .default(Text(alertItem.primaryButtonTitle))
            )
        }
    }
            
}

#Preview {
    AppetizerListView()
}

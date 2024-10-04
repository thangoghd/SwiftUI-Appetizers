//
//  AppetizerDetailView.swift
//  SwiftUI-Appetizers
//
//  Created by Ha Viet Thang on 26/9/24.
//

import SwiftUI

struct AppetizerDetailView: View {
    let appetizer: AppetizersModel
    @Binding var isShowing: Bool
    @Binding var isAnimation: Bool
    var body: some View {
        VStack{
            AsyncImage(url: URL(string: AppConstants.BASE_URL + AppConstants.UPLOAD_URL + appetizer.img)){ image in
                image.resizable().aspectRatio(contentMode: .fill)
            } placeholder: {
                ProgressView()
            }.frame(height: 200).clipShape(.rect(cornerRadius: 8))
            
            VStack{
                Text(appetizer.name).font(.title2).fontWeight(.semibold)
                Text(appetizer.description).multilineTextAlignment(.center).font(.body).padding()
            }
            VStack(spacing: 40){
                HStack{
                    Text("Rating").font(.caption).fontWeight(.bold)
                    HStack{
                        ReviewStars(score: appetizer.stars)
                    }
                }
                VStack{
                    Text("Location").font(.caption).fontWeight(.bold)
                    Text(appetizer.location).foregroundStyle(.secondary).fontWeight(.semibold).italic()
                }
            }
            Spacer()
            
            Button{
                print("tapped")
            } label: {
                Text("$\(appetizer.price, specifier: "%.2f") - Order").font(.title3).fontWeight(.semibold).frame(width: 260, height: 50).foregroundStyle(.white).background(Color.mainColor).clipShape(.rect(cornerRadius: 40))
            }
            .padding(.bottom, 30)
        }.frame(width: 320, height: 600).background(Color(.systemBackground)).clipShape(.rect(cornerRadius: 40)).shadow(radius: 40)
            .overlay(Button{
                withAnimation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0)) {
                    isAnimation = false // Hoạt ảnh thu nhỏ khi đóng
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { // Chờ hoạt ảnh kết thúc
                    isShowing = false
                }
            } label: {
                ZStack{
                    Circle().frame(width: 30, height: 30).foregroundStyle(.white).opacity(0.6)
                    Image(systemName: "xmark").imageScale(.medium).frame(width: 44, height: 44).foregroundStyle(.gray)
                }
            }, alignment:.topTrailing)
    }
}

struct ReviewStars: View {
    @State var score: Float

    var body: some View {
        HStack(spacing: 2) {
            ForEach(0..<5) { index in
                self.starView(for: index)
                    .frame(width: 20, height: 20)
            }
        }
    }

    func starView(for index: Int) -> some View {
        let starScore = score - Float(index)
        let fillRatio = max(0, min(1, starScore)) // Tỉ lệ màu của mỗi sao
        
        return ZStack(alignment: .leading) {
            Image(systemName: "star.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.gray)

            // Phần này tạo ra gradient từ trái sang phải
            GeometryReader { geometry in
                Rectangle()
                    .foregroundColor(.yellow)
                    .frame(width: geometry.size.width * CGFloat(fillRatio))
            }
            .mask(Image(systemName: "star.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit))
        }
    }
}


#Preview {
    AppetizerDetailView(appetizer: MockData.sampleAppetizer, isShowing: .constant(true), isAnimation: .constant(true))
}

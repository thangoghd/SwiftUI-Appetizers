//
//  AppetizerDetailView.swift
//  SwiftUI-Appetizers
//
//  Created by Ha Viet Thang on 26/9/24.
//

import SwiftUI

struct AppetizerDetailView: View {
    let appetizer: AppetizersModel
    @ObservedObject var controller: AppetizerController
    @ObservedObject var cartController: CartController
    @Binding var isShowing: Bool
    @Binding var isAnimation: Bool
    @State private var showingAlert = false
    
    var body: some View {
        VStack {
            AsyncImage(url: URL(string: AppConstants.BASE_URL + AppConstants.UPLOAD_URL + appetizer.img)){ image in
                image.resizable().aspectRatio(contentMode: .fill)
            } placeholder: {
                ProgressView()
            }.frame(height: 200).clipShape(.rect(cornerRadius: 8))
            
            VStack{
                Text(appetizer.name).font(.title2).fontWeight(.semibold)
                Text(appetizer.description).multilineTextAlignment(.center).font(.body).padding()
            }
            VStack(spacing: 30){
                HStack{
                    Text("Rating").font(.caption).fontWeight(.bold)
                    HStack{
                        ReviewStars(score: appetizer.stars)
                    }
                }
                HStack(spacing: 20){
                    VStack{
                        Text("Location").font(.caption).fontWeight(.bold)
                        Text(appetizer.location).foregroundStyle(.secondary).fontWeight(.semibold).italic()
                    }
                    HStack(spacing: 20) {
                        Button(action: {
                            controller.changeQuantity(for: appetizer.id, isIncrement: false)
                        }) {
                            Text("-")
                        }
                        Text("\(controller.getQuantity(for: appetizer.id))").foregroundStyle(.red)
                        Button(action: {
                            controller.changeQuantity(for: appetizer.id, isIncrement: true)
                        }) {
                            Text("+")
                        }
                    }.padding(10).overlay(RoundedRectangle(cornerRadius: 20).stroke(.gray, lineWidth: 1))
                }
            }
            Spacer()
            HStack{
                Button {
                    cartController.addToCart(appetizer, quantity: controller.getQuantity(for: appetizer.id))
                    showingAlert = true
                } label: {
                    Text("Add to your cart")
                        .font(.system(size: 13)).fontWeight(.semibold)
                        .frame(width: 100, height: 50)
                        .foregroundStyle(.white)
                        .background(Color.orange)
                        .clipShape(.rect(cornerRadius: 30))
                }
                
                Button {
                    print("Order tapped")
                } label: {
                    Text("$\(appetizer.price * Double(controller.getQuantity(for: appetizer.id)), specifier: "%.2f") - Order")
                        .font(.system(size: 13)).fontWeight(.semibold)
                        .frame(width: 200, height: 50)
                        .foregroundStyle(.white)
                        .background(Color.mainColor)
                        .clipShape(.rect(cornerRadius: 30))
                }
            }.padding(.bottom, 30)
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text("Added to Cart"), message: Text("\(appetizer.name) has been added to your cart."), dismissButton: .default(Text("OK")))
        }
        .frame(width: 320, height: 600).background(Color(.systemBackground)).clipShape(.rect(cornerRadius: 40)).shadow(radius: 40)
            .overlay(Button{
                withAnimation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0)) {
                    isAnimation = false
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    isShowing = false
                }
            } label: {
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
        // Check if score is less than index
        let fillRatio = max(0, min(1, starScore))
        
        return ZStack(alignment: .leading) {
            Image(systemName: "star.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.gray)

            // The filled part of the star 
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
    AppetizerDetailView(
        appetizer: MockData.sampleAppetizer,
        controller: AppetizerController(),
        cartController: CartController(),
        isShowing: .constant(true),
        isAnimation: .constant(true)
    )
    .environmentObject(CartController())
}

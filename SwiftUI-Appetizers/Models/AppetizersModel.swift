//
//  ModelAppetizers.swift
//  SwiftUI-Appetizers
//
//  Created by Ha Viet Thang on 25/9/24.
//

import Foundation

struct AppetizersModel: Decodable, Identifiable{
    let id: Int
    let name: String
    let description: String
    let price: Double
    let stars: Float
    let img: String
    let location: String
    let type_id: Int
}


struct AppetizerRespone: Decodable{
    let products: [AppetizersModel]
}

struct MockData{
    static let sampleAppetizer = AppetizersModel(id: 1, name: "Noodle", description: "Yummy", price: 5, stars: 4.7, img: "placehilderImage", location: "Hai Phong", type_id: 2)
    
    static let listSample = [sampleAppetizer, sampleAppetizer, sampleAppetizer]
}


final class AppetizerListViewModel: ObservableObject{
    @Published var alertItem: AppAlerts?
    @Published var appertizers: [AppetizersModel] = []
    @Published var isLoading = false
    @Published var isShowingDetail = false
    @Published var isAnimation = false
    @Published var selectedAppetizer: AppetizersModel?
    func getAppetizers(){
        isLoading = true
        AppetizerController.shared.getAppetizers{ result in
            DispatchQueue.main.async{
                self.isLoading = false
                switch result{
                case .success(let listAppetizers): self .appertizers = listAppetizers
                case .failure(let error):
                    switch error{
                    case .invalidResponse: self.alertItem = AlertContext.invalidResponse
                    case .invalidURL: self.alertItem = AlertContext.invalidURL
                    case .invalidData: self.alertItem = AlertContext.invalidData
                    case .unnableToComplete: self.alertItem = AlertContext.unbaleToComplete
                    }
                }
            }
        }
    }
}

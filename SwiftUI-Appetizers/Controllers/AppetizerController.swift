//
//  AppetizerController.swift
//  SwiftUI-Appetizers
//
//  Created by Ha Viet Thang on 25/9/24.
//

import Foundation
import UIKit

final class AppetizerController: ObservableObject {
    @Published private var quantities: [Int: Int] = [:]
    
    static let shared = AppetizerController()
    
    init() {}
    
    func getQuantity(for appetizerID: Int) -> Int {
        return quantities[appetizerID] ?? 1
    }
    
    func setQuantity(_ quantity: Int, for appetizerID: Int) {
        quantities[appetizerID] = max(1, min(quantity, 20))
    }
    
    func changeQuantity(for appetizerID: Int, isIncrement: Bool) {
        let currentQuantity = getQuantity(for: appetizerID)
        if isIncrement{ setQuantity(currentQuantity + 1, for: appetizerID)}
        else {setQuantity(currentQuantity - 1, for: appetizerID)}
    }
    
    
    func getAppetizers(completed: @escaping (Result<[AppetizersModel], AppErrors>) -> Void){
        guard let url = URL(string: AppConstants.BASE_URL + AppConstants.RECOMMENDED_PRODUCT_URL) else{
            completed(.failure(.invalidURL))
            return
        }
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)){data, response, error in
            if let _ = error{
                completed(.failure(.unnableToComplete))
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
                completed(.failure(.invalidResponse))
                return
            }
            guard let data = data else{
                completed(.failure(.invalidData))
                return
            }
            
            do{
                let decoder = JSONDecoder()
                let decodedResponse = try decoder.decode(AppetizerRespone.self, from: data)
                completed(.success(decodedResponse.products))
            } catch {
                completed(.failure(.invalidData))
            }
            
        }
        task.resume()
    }
    
    func showSnackbar(title: String, message: String) {
        // Display a notification as a UIAlertController
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

        // Present the alert to the userN
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = scene.windows.first {
            if let topController = window.rootViewController {
                topController.present(alert, animated: true, completion: nil)
            }
        }
    }

}



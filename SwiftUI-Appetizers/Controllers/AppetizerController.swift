//
//  NetworkController.swift
//  SwiftUI-Appetizers
//
//  Created by Ha Viet Thang on 25/9/24.
//

import Foundation
 
final class AppetizerController{
    static let shared = AppetizerController()
    
    private init(){
        
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
}

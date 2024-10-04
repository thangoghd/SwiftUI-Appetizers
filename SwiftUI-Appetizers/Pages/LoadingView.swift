//
//  LoadingView.swift
//  SwiftUI-Appetizers
//
//  Created by Ha Viet Thang on 25/9/24.
//

import SwiftUI

struct ActivityIndicator: UIViewRepresentable {
    func makeUIView(context: Context) -> UIActivityIndicatorView{
        let activityIndicatorView = UIActivityIndicatorView(style: .large)
        activityIndicatorView.color = UIColor.mainUIColor
        activityIndicatorView.startAnimating()
        return activityIndicatorView
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context){
        
    }
}

struct LoadingView: View {
    var body: some View {
        ZStack{
            Color(.systemBackground).ignoresSafeArea(edges: .all)
            
            ActivityIndicator()
        }
    }
}

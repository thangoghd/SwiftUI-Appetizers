//
//  UserModel.swift
//  SwiftUI-Appetizers
//
//  Created by Ha Viet Thang on 28/9/24.
//

import SwiftUI

extension String{
    var isValidEmail: Bool{
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9._]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: self)
    }
}

final class UserModel: ObservableObject{
//    @AppStorage("user") private var userData: Data?
//    @Published var firstName = "Ha"
//    @Published var lastName = "Viet Thang"
//    @Published var email = ""
//    @Published var phone = ""
//    @Published var birthDay = Date()
//    @Published var extraNapkins = false
//    @Published var frequenRefills = false
    
    @AppStorage("firstName") var firstName: String = ""
    @AppStorage("lastName") var lastName: String = ""
    @AppStorage("email") var email: String = ""
    @AppStorage("phone") var phone: String = ""
    @AppStorage("birthDay") var birthDay: Date = Date()
    @AppStorage("extraNapkins") var extraNapkins: Bool = false
    @AppStorage("frequenRefills") var frequenRefills: Bool = false
    
    @Published var alertItems: AppAlerts?
    
    var isValidForm: Bool{
        guard !firstName.isEmpty && !lastName.isEmpty && !email.isEmpty && !phone.isEmpty else{
            alertItems = AlertContext.invalidForm
            return false
        }
        
        guard email.isValidEmail else{
            alertItems = AlertContext.invalidEmail
            return false
        }
        return true
    }
    
    func saveChanges(){
        guard isValidForm else{
            return
        }
        alertItems = AlertContext.userSaveSuccess
    }
    
//    func retrieveUser(){
//        guard let userData = userData else {return }
//        do {
//            user = try JSONEncoder().decode(UserModel.self, from: userData)
//        }
//        catch{
//            alertItems = AlertContext.invalidData
//        }
//    }
}

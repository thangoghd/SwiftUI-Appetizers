//
//  AppAlerts.swift
//  SwiftUI-Appetizers
//
//  Created by Ha Viet Thang on 25/9/24.
//

import SwiftUI

struct AppAlerts: Identifiable{
    let id = UUID()
    let title: String
    let message: String
    let primaryButtonTitle: String
}

struct AlertContext{
    // MARK: Alerts in ListAppetizerView
    static let invalidData = AppAlerts(title: "Server Error", message: "The data received from the server was invalid!", primaryButtonTitle: "OK")
    static let invalidResponse = AppAlerts(title: "Server Error", message: "Invalid reponse form ther server!", primaryButtonTitle: "OK")
    static let invalidURL  = AppAlerts(title: "Server Error", message: "The data received from the server was invalid", primaryButtonTitle: "OK")
    static let unbaleToComplete = AppAlerts(title: "Server Error", message: "Unnable to complete your request at this time!", primaryButtonTitle: "OK")
    
    // MARK: ALerts in UserView
    static let invalidForm = AppAlerts(title: "Invalid From", message: "Please ensure all fields in the form have been filled out!", primaryButtonTitle: "OK")
    static let invalidEmail = AppAlerts(title: "Invalid Infomation", message: "The email is not correct format!", primaryButtonTitle: "OK")
    static let userSaveSuccess = AppAlerts(title: "Profile Saved", message: "Your profile was succesfully saved", primaryButtonTitle: "OK")
    static let userSaveFailed = AppAlerts(title: "Error While Saving", message: "An error while saving your proflie data", primaryButtonTitle: "OK")
}

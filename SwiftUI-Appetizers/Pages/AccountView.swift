//
//  AccountView.swift
//  SwiftUI-Appetizers
//
//  Created by Ha Viet Thang on 25/9/24.
//

import SwiftUI

struct AccountView: View {
    @StateObject private var viewModel = UserModel()
    var body: some View {
        NavigationView{
            Form{
                Section(header: Text("Personal Info")){
                    TextField("First Name", text: $viewModel.firstName)
                    TextField("Last Name", text: $viewModel.lastName)
                    TextField("Email", text: $viewModel.email).keyboardType(.emailAddress).textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                    TextField("Phone", text: $viewModel.phone).keyboardType(.phonePad)
                    DatePicker("Birthday", selection: $viewModel.birthDay, displayedComponents: .date)
                    
                    Button{
                        viewModel.saveChanges()
                    } label: {
                        Text("Save Changes")
                    }
                }
                Section(header: Text("Requests")){
                    Toggle("Extra Napkins", isOn: $viewModel.extraNapkins)
                    Toggle("Frequen Refills", isOn: $viewModel.frequenRefills)
                }.tint(.mainColor)
            }.navigationTitle("Account")
        }
        .alert(item: $viewModel.alertItems){ alertItem in
            Alert(
                title: Text(alertItem.title),
                message: Text(alertItem.message),
                dismissButton: .default(Text(alertItem.primaryButtonTitle))
            )
        }
    }
}

struct AccountView_Previews: PreviewProvider{
    static var previews: some View{
        AccountView()
    }
}


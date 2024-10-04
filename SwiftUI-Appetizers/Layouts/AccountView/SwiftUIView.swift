import SwiftUI

struct AccountView2: View {
    @State private var viewModel = UserModel()
    @State private var isAlertPresented = false  // Boolean to control alert presentation
    @State private var currentAlertItem: AlertItem? // To hold the current alert item for presenting

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Personal Info")) {
                    TextField("First Name", text: $viewModel.firstName)
                    TextField("Last Name", text: $viewModel.lastName)
                    TextField("Email", text: $viewModel.email)
                        .keyboardType(.emailAddress)
                        .textInputAutocapitalization(.none)
                        .autocorrectionDisabled()
                    TextField("Phone", text: $viewModel.phone)
                        .keyboardType(.phonePad)
                    DatePicker("Birthday", selection: $viewModel.birthDay, displayedComponents: .date)
                    
                    Button {
                        saveChanges()
                    } label: {
                        Text("Save Changes")
                    }
                }
                Section(header: Text("Requests")) {
                    Toggle("Extra Napkins", isOn: $viewModel.extraNapkins)
                    Toggle("Frequent Refills", isOn: $viewModel.frequenRefills)
                }.tint(.mainColor)
            }
            .navigationTitle("Account")
        }
        // Using alert(_:isPresented:presenting:actions:)
        .alert("Alert", isPresented: $isAlertPresented, presenting: currentAlertItem) { alertItem in
            Button(alertItem.primaryButtonTitle, role: .cancel) { }
        } message: { alertItem in
            Text(alertItem.message)
        }
    }
    
    // Function to trigger the alert
    private func saveChanges() {
        // Assuming some validation logic, e.g., email is not valid
        if viewModel.email.isEmpty {
            currentAlertItem = AlertItem(
                title: "Invalid Email",
                message: "Please enter a valid email address.",
                primaryButtonTitle: "OK"
            )
            isAlertPresented = true
        } else {
            // Handle save logic
        }
    }
}

// Example of an alert item model
struct AlertItem {
    let title: String
    let message: String
    let primaryButtonTitle: String
}




struct AccountView2_Previews: PreviewProvider {
    @State private var scoreDouble: Double = 4.5
    static var previews: some View {
        AccountView2()
    }
}


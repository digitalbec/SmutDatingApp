import SwiftUI

struct LoginRegisterView: View {
    @State private var isRegistering = false
    @State private var email = ""
    @State private var password = ""
    @State private var name = ""
    @State private var isLoggedIn = false

    var body: some View {
        if isLoggedIn {
            DiscoveryView() // Show main app after login/register
        } else {
            VStack(spacing: 30) {
                Text(isRegistering ? "Register" : "Login")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                if isRegistering {
                    TextField("Name", text: $name)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                }
                TextField("Email", text: $email)
                    .autocapitalization(.none)
                    .keyboardType(.emailAddress)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                SecureField("Password", text: $password)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                
                Button(action: {
                    // Simple validation, replace with real auth logic
                    if !email.isEmpty && !password.isEmpty && (!isRegistering || !name.isEmpty) {
                        isLoggedIn = true
                    }
                }) {
                    Text(isRegistering ? "Register" : "Login")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(8)
                }
                
                Button(action: {
                    isRegistering.toggle()
                }) {
                    Text(isRegistering ? "Already have an account? Login" : "Don't have an account? Register")
                        .font(.footnote)
                        .foregroundColor(.blue)
                }
            }
            .padding()
        }
    }
}
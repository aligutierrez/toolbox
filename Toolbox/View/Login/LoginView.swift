//
//  LoginView.swift
//  Toolbox
//
//  Created by Ali Gutierrez on 7/13/21.
//

import SwiftUI

struct LoginView: View {

    @State private var sub = ""
    @State private var loginError = false
    @State private var loginErrorString = ""
    
    @EnvironmentObject var viewModel: LoginViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            
            HStack {
                Spacer()
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 50)
                    .padding(.top, 50)
                    .padding(.bottom, 200)
                Spacer()
            }
            
            
            TextField("Sub", text: self.$sub)
                .padding()
                .background(Color.themeTextField)
                .cornerRadius(20.0)
            
            HStack {
                Spacer()
                Button(action: {
                    viewModel.setSub(sub)
                    self.doLogin()
                }) {
                    Text("Sign In")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.green)
                        .cornerRadius(15.0)
                        .shadow(radius: 10.0, x: 20, y: 10)
                }.padding(.top, 50)
                Spacer()
            }
            Spacer()
            
        }
        .padding([.leading, .trailing], 27.5)
        .alert(isPresented: $loginError) {
                    Alert(title: Text("Oops"), message: Text(loginErrorString), dismissButton: .default(Text("Ok")))
                }
    }
    
    func doLogin() {
        viewModel.doLogin { user, error in
            if let error = error {
                loginError = true
                loginErrorString = error.localizedDescription
                viewModel.needsAuthentication = true
                viewModel.isLoggedIn = false
                return
            }
            
            viewModel.isAuthenticating = false
            viewModel.needsAuthentication = false
            viewModel.isLoggedIn = true
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

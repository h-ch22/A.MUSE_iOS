//
//  ResetPasswordView.swift
//  A.MUSE
//
//  Created by 하창진 on 7/17/24.
//

import SwiftUI
import Neumorphic

struct ResetPasswordView: View {
    @State private var email = ""
    @State private var showProgress = false
    @State private var showAlert = false
    @State private var alertType: UserManagementAlertType? = nil
    
    @State private var helper = UserManagement()
    
    var body: some View {
        ZStack{
            Color.backgroundColor.ignoresSafeArea()
            
            VStack{
                Image("ic_appstore")
                    .resizable()
                    .frame(width: 150, height: 150)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .shadow(radius: 5)
                
                Text("Reset Password")
                    .font(.title)
                
                Spacer().frame(height: 10)
                
                Text("If you enter the email you signed up for in the field below, we will send you a password reset email.")
                    .font(.caption)
                    .foregroundStyle(Color.gray)
                    .multilineTextAlignment(.center)
                
                Spacer().frame(height: 20)
                
                HStack {
                    Image(systemName: "at.circle.fill")
                        .foregroundStyle(email == "" ? Color.gray : Color.accentColor)
                    
                    TextField("E-Mail", text: $email)
                        .keyboardType(.emailAddress)
                }
                .foregroundStyle(Color.accentColor)
                .padding(20)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .shadow(radius: 5)
                
                Spacer().frame(height: 20)
                
                Button(action: {
                    showProgress = true
                    
                    helper.sendResetPasswordMail(email: email, completion: { result in
                        guard let result = result else {return}
                        
                        showProgress = false
                        alertType = result ? .SENT_PASSWORD_RESET_MAIL : .UNKNOWN_ERROR
                        showAlert = true
                    })
                }){
                    HStack{
                        Text("Send Password Reset Mail")
                        Spacer().frame(width: 10)
                        Image(systemName: "chevron.right")
                    }
                }.softButtonStyle(RoundedRectangle(cornerRadius: 15))
            }.navigationTitle(Text("Forgot Password"))
                .padding(20)
                .alert(isPresented: $showAlert, error: alertType){ _ in
                    Button("OK"){
                        showAlert = false
                        alertType = nil
                    }
                } message: { error in
                    Text(error.recoverySuggestion ?? "")
                }
        }
    }
}

#Preview {
    ResetPasswordView()
}

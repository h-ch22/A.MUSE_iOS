//
//  SignInView.swift
//  A.MUSE
//
//  Created by 하창진 on 7/17/24.
//

import SwiftUI
import Neumorphic

struct SignInView: View {
    @StateObject private var helper = UserManagement()
    
    @State private var email = ""
    @State private var password = ""
    
    @State private var showProgress = false
    @State private var showAlert = false
    @State private var alertType: UserManagementAlertType? = nil
    
    @State private var showMainView = false
    
    @AppStorage("auth_email") var auth_email = UserDefaults.standard.string(forKey: "auth_email") ?? ""
    @AppStorage("auth_password") var auth_password = UserDefaults.standard.string(forKey: "auth_password") ?? ""
    
    var body: some View {
        NavigationStack{
            ZStack{
                Color.backgroundColor.ignoresSafeArea()
                
                VStack{
                    Image("ic_appstore")
                        .resizable()
                        .frame(width: 150, height: 150)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .shadow(radius: 5)
                    
                    Text("__A__.MUSE")
                        .font(.title)
                    
                    Spacer()
                    
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
                    
                    HStack {
                        Image(systemName: "key.fill")
                            .foregroundStyle(password == "" ? Color.gray : Color.accentColor)
                        
                        SecureField("Password", text: $password)
                    }
                    .foregroundStyle(Color.accentColor)
                    .padding(20)
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .shadow(radius: 5)
                    
                    Spacer().frame(height: 20)
                    
                    if showProgress {
                        DotProgressView()
                    } else {
                        Button(action: {
                            if email == "" || password == "" {
                                alertType = .EMPTY_FIELD
                                showAlert = true
                            } else if !email.contains("@"){
                                alertType = .INVALID_EMAIL_TYPE
                                showAlert = true
                            } else {
                                showProgress = true
                                
                                helper.signIn(email: email, password: password) { result in
                                    guard let result = result else { return }
                                    
                                    showProgress = false
                                    
                                    if !result {
                                        alertType = .ACCOUNT_DOES_NOT_EXISTS
                                        showAlert = true
                                    } else {
                                        auth_email = AES256Util.encrypt(string: email)
                                        auth_password = AES256Util.encrypt(string: password)
                                        showMainView = true
                                    }
                                }
                            }
                        }){
                            HStack{
                                Text("Sign In")
                                Image(systemName: "chevron.right")
                            }.padding([.horizontal], 80)
                                .padding([.vertical], 5)
                        }
                        .softButtonStyle(RoundedRectangle(cornerRadius: 50))
                    }
                    
                    Spacer().frame(height: 20)

                    HStack{
                        NavigationLink(destination: ResetPasswordView()){
                            Text("Forgot Password")
                                .foregroundStyle(Color.txtColor)
                        }
                        
                        Spacer()
                        
                        NavigationLink(destination: SignUpView()){
                            Text("Sign Up")
                                .foregroundStyle(Color.txtColor)
                        }
                    }
                    
                    Spacer()
                    
                    Text("© 2024 Changjin Ha, Jisoo Park and Hwaram Park.\nAll rights reserved.")
                        .font(.caption)
                        .foregroundStyle(Color.gray)
                        .multilineTextAlignment(.center)
                    
                }.padding(20)
                    .toolbarVisibility(.hidden)
                    .navigationTitle(Text("Sign In"))
                    .alert(isPresented: $showAlert, error: alertType){ _ in
                        Button("OK"){
                            showAlert = false
                            alertType = nil
                        }
                    } message: { error in
                        Text(error.recoverySuggestion ?? "")
                    }
                    .fullScreenCover(isPresented: $showMainView, content: {
                        MainView()
                            .environmentObject(UserManagement())
                    })
                    .onAppear {
                        if auth_email != "" && auth_password != "" {
                            showProgress = true
                            
                            helper.signIn(email: AES256Util.decrypt(encoded: auth_email), password: AES256Util.decrypt(encoded: auth_password)) { result in
                                guard let result = result else { return }
                                
                                showProgress = false
                                
                                if !result {
                                    alertType = .ACCOUNT_DOES_NOT_EXISTS
                                    showAlert = true
                                } else {
                                    showMainView = true
                                }
                            }
                        }
                    }
            }
        }
    }
}

#Preview {
    SignInView()
}

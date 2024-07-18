//
//  SignUpView.swift
//  A.MUSE
//
//  Created by 하창진 on 7/17/24.
//

import SwiftUI
import Neumorphic

struct SignUpView: View {
    @StateObject private var helper = UserManagement()
    
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var name = ""
    @State private var nickName = ""
    @State private var phoneNumber = ""
    @State private var birthday = Date()
    
    @State private var acceptEULA = false
    @State private var acceptPrivacyLicense = false
    
    @State private var showProgress = false
    @State private var showAlert = false
    @State private var alertType: UserManagementAlertType? = nil
    
    @State private var showMainView = false
    
    var body: some View {
        ZStack{
            Color.backgroundColor.ignoresSafeArea()
            
            ScrollView{
                VStack{
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
                    
                    HStack {
                        Image(systemName: "key.fill")
                            .foregroundStyle(confirmPassword == "" ? Color.gray : Color.accentColor)
                        
                        SecureField("Confirm Password", text: $confirmPassword)
                    }
                    .foregroundStyle(Color.accentColor)
                    .padding(20)
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .shadow(radius: 5)
                    
                    Spacer().frame(height: 20)
                    
                    HStack {
                        Image(systemName: "person.fill.viewfinder")
                            .foregroundStyle(name == "" ? Color.gray : Color.accentColor)
                        
                        TextField("Name", text: $name)
                    }
                    .foregroundStyle(Color.accentColor)
                    .padding(20)
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .shadow(radius: 5)
                    
                    Spacer().frame(height: 20)
                    
                    HStack {
                        Image(systemName: "person.fill")
                            .foregroundStyle(nickName == "" ? Color.gray : Color.accentColor)
                        
                        TextField("Nickname", text: $nickName)
                    }
                    .foregroundStyle(Color.accentColor)
                    .padding(20)
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .shadow(radius: 5)
                    
                    Spacer().frame(height: 20)
                    
                    HStack {
                        Image(systemName: "phone.fill")
                            .foregroundStyle(phoneNumber == "" ? Color.gray : Color.accentColor)
                        
                        TextField("Phone Number", text: $phoneNumber)
                            .keyboardType(.phonePad)
                    }
                    .foregroundStyle(Color.accentColor)
                    .padding(20)
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .shadow(radius: 5)
                    
                    Spacer().frame(height: 20)
                    
                    DatePicker("Birthday", selection: $birthday, in: ...Date(), displayedComponents: [.date])
                    
                    Spacer().frame(height: 20)
                    
                    HStack{
                        Toggle(isOn: $acceptEULA, label: {
                            Image(systemName: acceptEULA ? "checkmark" : "circlebadge")
                        }).softToggleStyle(Circle(), padding: 10)
                        
                        Spacer().frame(width: 10)
                        
                        Text("Accept EULA")
                        
                        Spacer()
                        
                        Button(action: {}){
                            Text("Read")
                        }
                    }
                    
                    HStack{
                        Toggle(isOn: $acceptPrivacyLicense, label: {
                            Image(systemName: acceptPrivacyLicense ? "checkmark" : "circlebadge")
                        }).softToggleStyle(Circle(), padding: 10)
                        
                        Spacer().frame(width: 10)
                        
                        Text("Accept Privacy License")
                        
                        Spacer()
                        
                        Button(action: {}){
                            Text("Read")
                        }
                    }
                    
                    Spacer().frame(height: 20)
                    
                    if showProgress {
                        DotProgressView()
                    } else {
                        Button(action: {
                            if email == "" || password == "" || confirmPassword == "" || name == "" || phoneNumber == "" || nickName == "" {
                                alertType = .EMPTY_FIELD
                                showAlert = true
                            } else if password != confirmPassword {
                                alertType = .PASSWORD_MISMATCH
                                showAlert = true
                            } else if !email.contains("@"){
                                alertType = .INVALID_EMAIL_TYPE
                                showAlert = true
                            } else if password.count < 8 {
                                alertType = .WEAK_PASSWORD
                                showAlert = true
                            } else if !acceptEULA || !acceptPrivacyLicense {
                                alertType = .LICENSE_NOT_ACCEPTED
                                showAlert = true
                            } else {
                                showProgress = true
                                
                                let dateFormatter = DateFormatter()
                                dateFormatter.dateFormat = "MM.dd.yyyy"
                                
                                helper.signUp(email: email, password: password, name: name, nickName: nickName, phoneNumber: phoneNumber, birthday: dateFormatter.string(from: birthday)){ result in
                                    guard let result = result else { return }
                                    
                                    showProgress = false
                                    
                                    if !result {
                                        alertType = .UNKNOWN_ERROR
                                        showAlert = true
                                    } else {
                                        showMainView = true
                                    }
                                }
                            }
                        }){
                            HStack{
                                Text("Sign Up")
                                Image(systemName: "chevron.right")
                            }.padding([.horizontal], 80)
                                .padding([.vertical], 5)
                        }
                        .softButtonStyle(RoundedRectangle(cornerRadius: 50))
                    }
                    
                }.padding(20)
                    .navigationTitle(Text("Sign Up"))
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
            }
        }
    }
}

#Preview {
    SignUpView()
}

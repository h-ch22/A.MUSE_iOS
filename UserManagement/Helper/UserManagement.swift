//
//  UserManagement.swift
//  A.MUSE
//
//  Created by 하창진 on 7/17/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class UserManagement: ObservableObject {
    @Published var userInfo: UserInfoModel? = nil
    
    private let auth = Auth.auth()
    private let db = Firestore.firestore()
    
    func signIn(email: String, password: String, completion: @escaping(_ result: Bool?) -> Void){
        auth.signIn(withEmail: email, password: password){ _, error in
            if error != nil{
                print(error?.localizedDescription ?? "Failed to sign in")
                completion(false)
                return
            }
            
            self.getUserInfo() { result in
                guard let result = result else { return }
                
                completion(result)
                return
            }
        }
    }
    
    func signUp(email: String, password: String, name: String, nickName: String, phoneNumber: String, birthday: String, completion: @escaping(_ result: Bool?) -> Void){
        auth.createUser(withEmail: email, password: password){ _, error in
            if error != nil {
                print(error?.localizedDescription ?? "Failed to create user")
                completion(false)
                return
            }
            
            self.db.collection("Users").document(self.auth.currentUser?.uid ?? "").setData([
                "email": AES256Util.encrypt(string: email),
                "name": AES256Util.encrypt(string: name),
                "nickName": AES256Util.encrypt(string: nickName),
                "phoneNumber": AES256Util.encrypt(string: phoneNumber),
                "birthday": AES256Util.encrypt(string: birthday)
            ]){ error in
                if error != nil{
                    print(error?.localizedDescription ?? "Failed to set user's document")
                    completion(false)
                    return
                }
                
                self.getUserInfo(){ result in
                    guard let result = result else { return }
                    completion(result)
                    return
                }
            }
        }
    }
    
    func sendResetPasswordMail(email: String, completion: @escaping(_ result: Bool?) -> Void){
        auth.sendPasswordReset(withEmail: email, completion: { error in
            if error != nil{
                print(error?.localizedDescription)
            }
            
            completion(error == nil)
            return
        })
    }
    
    private func getUserInfo(completion: @escaping(_ result: Bool?) -> Void){
        if auth.currentUser == nil {
            completion(false)
            return
        }
        
        db.collection("Users").document(auth.currentUser!.uid).getDocument(){ document, error in
            if error != nil{
                print(error?.localizedDescription ?? "Failed to get document for User \(self.auth.currentUser!.uid)")
                completion(false)
                return
            }
            
            if document != nil && document!.exists {
                let name = document?.get("name") as? String ?? ""
                let email = document?.get("email") as? String ?? ""
                let nickname = document?.get("nickName") as? String ?? ""
                let phoneNumber = document?.get("phoneNumber") as? String ?? ""
                let birthday = document?.get("birthday") as? String ?? ""
                
                self.userInfo = UserInfoModel(email: AES256Util.decrypt(encoded: email), name: AES256Util.decrypt(encoded: name), nickName: AES256Util.decrypt(encoded: nickname), phoneNumber: AES256Util.decrypt(encoded: phoneNumber), birthday: AES256Util.decrypt(encoded: birthday))
                
                completion(true)
                return
            } else {
                completion(false)
                return
            }
        }
    }
}

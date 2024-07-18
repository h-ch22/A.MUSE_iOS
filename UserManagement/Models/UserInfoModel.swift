//
//  UserInfoModel.swift
//  A.MUSE
//
//  Created by 하창진 on 7/17/24.
//

struct UserInfoModel {
    let email: String
    let name: String
    let nickName: String
    let phoneNumber: String
    let birthday: String
    
    init(email: String, name: String, nickName: String, phoneNumber: String, birthday: String) {
        self.email = email
        self.name = name
        self.nickName = nickName
        self.phoneNumber = phoneNumber
        self.birthday = birthday
    }
}

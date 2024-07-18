//
//  UserManagementAlertType.swift
//  A.MUSE
//
//  Created by 하창진 on 7/17/24.
//

import Foundation

enum UserManagementAlertType: LocalizedError {
    case EMPTY_FIELD, ACCOUNT_DOES_NOT_EXISTS, INVALID_EMAIL_TYPE, WEAK_PASSWORD, PASSWORD_MISMATCH, LICENSE_NOT_ACCEPTED, UNKNOWN_ERROR, SENT_PASSWORD_RESET_MAIL
    
    var errorDescription: String? {
        switch self {
        case .EMPTY_FIELD:
            return "Empty Field"
            
        case .ACCOUNT_DOES_NOT_EXISTS:
            return "Non-existent account"
            
        case .INVALID_EMAIL_TYPE:
            return "Invalid E-Mail type"
            
        case .WEAK_PASSWORD:
            return "Weak Password"
            
        case .PASSWORD_MISMATCH:
            return "Password Mismatch"
            
        case .LICENSE_NOT_ACCEPTED:
            return "Disagree with the Licenses"
            
        case .UNKNOWN_ERROR:
            return "Error"
            
        case .SENT_PASSWORD_RESET_MAIL:
            return "Done"
        }
    }
    
    var recoverySuggestion: String? {
        switch self {
        case .EMPTY_FIELD:
            return "Please fill in all the fields."
            
        case .ACCOUNT_DOES_NOT_EXISTS:
            return "The account does not exist. Please check the information you entered or the status of your network."
            
        case .INVALID_EMAIL_TYPE:
            return "Please enter a valid e-mail type address."
            
        case .WEAK_PASSWORD:
            return "For security purposes, please enter a password of at least 8 digits."
            
        case .PASSWORD_MISMATCH:
            return "Password and password verification do not match."
            
        case .LICENSE_NOT_ACCEPTED:
            return "Please read and agree to all the licenses"
            
        case .UNKNOWN_ERROR:
            return "There was an error in the process of signing up for membership. Please check if you are already signed up for an email, or check your network status and try again."
            
        case .SENT_PASSWORD_RESET_MAIL:
            return "A password reset email has been sent to the email you entered."
        }
    }
}

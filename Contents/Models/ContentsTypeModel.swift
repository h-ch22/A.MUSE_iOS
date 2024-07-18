//
//  ContentsTypeModel.swift
//  A.MUSE
//
//  Created by 하창진 on 7/18/24.
//

enum ContentsTypeModel: String{
    case BOOK = "도서"
    case MOVIE = "영화"
    case CULTURE = "문화"
    case ETC = "기타"
    
    func convertEngStringToModel(engType: String) -> Self {
        switch engType {
        case "Book": return .BOOK
        case "Movie": return .MOVIE
        case "Culture": return .CULTURE
        case "ETC": return .ETC
        default: return .ETC
        }
    }
    
    func convertTypeToEngString(type: Self) -> String {
        switch type {
        case .BOOK:
            return "Book"
        case .MOVIE:
            return "Movie"
        case .CULTURE:
            return "Culture"
        case .ETC:
            return "ETC"
        }
    }
}

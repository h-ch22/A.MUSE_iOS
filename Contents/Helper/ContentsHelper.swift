//
//  ContentsHelper.swift
//  A.MUSE
//
//  Created by 하창진 on 7/18/24.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage

class ContentsHelper: ObservableObject {
    @Published var bookContentsList = [ContentsDataModel]()
    @Published var cultureContentsList = [ContentsDataModel]()
    @Published var movieContentsList = [ContentsDataModel]()
    @Published var etcContentsList = [ContentsDataModel]()
    
    private let db = Firestore.firestore()
    private let storage = Storage.storage()
    
    func getContents(type: ContentsTypeModel, completion: @escaping(_ result: Bool?) -> Void){
        switch type {
        case .BOOK:
            bookContentsList.removeAll()
            
        case .MOVIE:
            movieContentsList.removeAll()
            
        case .CULTURE:
            cultureContentsList.removeAll()
            
        case .ETC:
            etcContentsList.removeAll()
        }
        
        db.collection("Contents").whereField("type", isEqualTo: AES256Util.encrypt(string: type.convertTypeToEngString(type: type))).getDocuments(){ (querySnapshot, error) in
            if error != nil {
                print(error?.localizedDescription)
                completion(false)
                return
            }
            
            if querySnapshot == nil || querySnapshot!.isEmpty {
                completion(true)
                return
            }
            
            for document in querySnapshot!.documents {
                let id = document.documentID
                let author = document.get("author") as? String ?? ""
                let publisher = document.get("publisher") as? String ?? ""
                let title = document.get("title") as? String ?? ""
                let summary = document.get("summary") as? String ?? ""
                let url = document.get("url") as? String ?? ""
                
                self.storage.reference().child("/contents/\(type.convertTypeToEngString(type: type))/\(id).png").downloadURL() { (downloadURL, error) in
                    if error != nil {
                        print(error?.localizedDescription)
                        completion(false)
                        return
                    }
                    
                    let data = ContentsDataModel(id: id, title: AES256Util.decrypt(encoded: title), author: AES256Util.decrypt(encoded: author), publisher: AES256Util.decrypt(encoded: publisher), summary: AES256Util.decrypt(encoded: summary), url: URL(string: AES256Util.decrypt(encoded: url))!, cover: downloadURL, type: type)
                    
                    switch type {
                    case .BOOK:
                        self.bookContentsList.append(data)
                        
                    case .MOVIE:
                        self.movieContentsList.append(data)
                        
                    case .CULTURE:
                        self.cultureContentsList.append(data)
                        
                    case .ETC:
                        self.etcContentsList.append(data)
                    }
                }
            }
            
            completion(true)
            return
        }
    }
}

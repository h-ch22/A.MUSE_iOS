//
//  BannersHelper.swift
//  A.MUSE
//
//  Created by 하창진 on 7/17/24.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage

class BannersHelper: ObservableObject {
    @Published var bannerList = [BannerDataModel]()
    
    private let db = Firestore.firestore()
    private let storage = Storage.storage()
    
    func getBanners(completion: @escaping(_ result: Bool?) -> Void){
        bannerList.removeAll()
        
        db.collection("Banners").document("BannerInfo").getDocument(){ (document, error) in
            if error != nil {
                print(error?.localizedDescription)
                completion(false)
                return
            }
            
            if document != nil && document!.exists {
                let bannerCount = document?.get("BannerCount") as? Int ?? 0
                
                for i in 0..<bannerCount {
                    self.db.collection("Banners").document("Banner_\(i)").getDocument(){(bannerDoc, err) in
                        if err != nil{
                            print(err?.localizedDescription)
                            completion(false)
                            return
                        }
                        
                        if bannerDoc != nil && bannerDoc!.exists{
                            let author = bannerDoc!.get("author") as? String ?? ""
                            let sentence = bannerDoc!.get("sentence") as? String ?? ""
                            let title = bannerDoc!.get("title") as? String ?? ""
                            
                            self.storage.reference().child("/banners/banner_\(i).png").downloadURL() {(downloadURL, error) in
                                if error != nil{
                                    print(error?.localizedDescription)
                                } else if downloadURL != nil{
                                    self.bannerList.append(
                                        BannerDataModel(id: i, url: downloadURL!, title: title, author: author, sentence: sentence)
                                    )
                                }
                            }
                        }
                    }
                }
                
                completion(true)
                return
            }
        }
    }
}

//
//  PostData.swift
//  Instagram
//
//  Created by 吉谷拓海 on 2020/07/01.
//  Copyright © 2020 takumi.yoshiya. All rights reserved.
//

import UIKit
import Firebase

class PostData: NSObject {
    
    var id: String
    var name: String?
    var caption: String?
    var date: Date?
    //likeの数
    var likes: [String] = []
    //likeした、しない
    var isLiked: Bool = false
    //コメント
    var comment: String!
    
    

    init(document: QueryDocumentSnapshot) {
        self.id = document.documentID

        let postDic = document.data()

        self.name = postDic["name"] as? String

        self.caption = postDic["caption"] as? String
        
        self.comment = postDic["comment"] as? String

        let timestamp = postDic["date"] as? Timestamp
        self.date = timestamp?.dateValue()

        if let likes = postDic["likes"] as? [String] {
            self.likes = likes
        }
        if let myid = Auth.auth().currentUser?.uid {
            // likesの配列の中にmyidが含まれているかチェックすることで、自分がいいねを押しているかを判断
            if self.likes.firstIndex(of: myid) != nil {
                // myidがあれば、いいねを押していると認識する。
                self.isLiked = true
            }
        }
    }
}

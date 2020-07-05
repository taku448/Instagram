//
//  PostTableViewCell.swift
//  Instagram
//
//  Created by 吉谷拓海 on 2020/07/01.
//  Copyright © 2020 takumi.yoshiya. All rights reserved.
//

import UIKit
import Firebase
import FirebaseUI
import SVProgressHUD
import SDWebImage



class PostTableViewCell: UITableViewCell {
    
    let postRef = Firestore.firestore().collection(Const.PostPath).document()
    

    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var captionLabel: UILabel!
    
    
    @IBOutlet weak var postCaptionTextField: UITextField!
    
    @IBAction func createCaptureButton(_ sender: Any) {
    }
    
    @IBAction func postCaptionButton(_ sender: Any) {
        
        let name = Auth.auth().currentUser?.displayName
                   let postDic = [
                       "name": name!,
                       "caption": self.postCaptionTextField.text!
                       ] as [String : Any]
                   postRef.setData(postDic)
                   // HUDで投稿完了を表示する
                   SVProgressHUD.showSuccess(withStatus: "投稿しました")
                   // 投稿処理が完了したので先頭画面に戻る
                  UIApplication.shared.windows.first{ $0.isKeyWindow }?.rootViewController?.dismiss(animated: true, completion: nil)
               }
    
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    // PostDataの内容をセルに表示
    func setPostData(_ postData: PostData) {
        // 画像の表示
        postImageView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        
        let imageRef = Storage.storage().reference().child(Const.ImagePath).child(postData.id + ".jpg")
        
        postImageView.sd_setImage(with: imageRef)

        // キャプションの表示
        self.captionLabel.text = "\(postData.name!) : \(postData.caption!)"

        // 日時の表示
        self.dateLabel.text = ""
        if let date = postData.date {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm"
            let dateString = formatter.string(from: date)
            self.dateLabel.text = dateString
        }

        // いいね数の表示
        let likeNumber = postData.likes.count
        likeLabel.text = "\(likeNumber)"

        // いいねボタンの表示
        if postData.isLiked {
            let buttonImage = UIImage(named: "like_exist")
            self.likeButton.setImage(buttonImage, for: .normal)
        } else {
            let buttonImage = UIImage(named: "like_none")
            self.likeButton.setImage(buttonImage, for: .normal)
        }
    }
}

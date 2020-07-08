//
//  MyCommentViewController.swift
//  Instagram
//
//  Created by 吉谷拓海 on 2020/07/08.
//  Copyright © 2020 takumi.yoshiya. All rights reserved.
//

import UIKit
import Firebase

class MyCommentViewController: UIViewController, UITextFieldDelegate  {
    
    @IBOutlet weak var myCommentTextField: UITextField!
    
    @IBOutlet weak var myCommentButton: UIButton!
    
    
    
    
    
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        // Initialization code
        
    }
    @IBAction func sendMyCommentButton(_ sender: Any) {
        
         print("DEBUG_PRINT: sendMyCommentButton")
        
        //投稿データの保存場所を定義する
        let postRef = Firestore.firestore().collection(Const.PostPath).document()
        //Firestoreに投稿データを保存する
        let name = Auth.auth().currentUser?.displayName
        let comments = "\(String(describing: name)) : \(String(describing: self.myCommentTextField.text))"
        
        postRef.updateData(["comments": comments])
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

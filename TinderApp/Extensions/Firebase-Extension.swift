//
//  Firebase-Extension.swift
//  TinderApp
//
//  Created by Juri Ohto on 2021/10/25.
//
import Firebase
import UIKit

// MARK: - Auth
extension Auth {
    
    static func createUserToFireAuth(name: String?, email: String?, password: String?, completion: @escaping (Bool) -> Void) {
        
        guard let email = email else { return }
        guard let password = password else { return }
        
        Auth.auth().createUser(withEmail: email, password: password) { (auth, err) in
            if let err = err {
                print("auth情報の保存に失敗: ", err)
                return
            }
            
            guard let uid = auth?.user.uid else { return }
            Firestore.setUserDataToFirestore(name: name, email: email, uid: uid) { success in
                completion(success)
            }
        }
    }
    
    static func loginWithFireAuth(email: String?, password: String?, completion: @escaping (Bool) -> Void) {
        
        guard let email = email else { return }
        guard let password = password else { return }
        
        
        Auth.auth().signIn(withEmail: email, password: password) { (res, err) in
            if let err = err {
                print("ログインに失敗: ", err)
                completion(false)
                return
            }
            print("ログインに成功")
            completion(true)
        }
    }
    
}

// MARK: - Firestore
extension Firestore {
    
    //ViewControllerで処理の完了を受け取る(コールバック)
    static func setUserDataToFirestore(name: String?, email: String, uid: String, completion: @escaping (Bool) -> ()) {
        
        guard let name = name else { return }
        
        let document: [String: Any] = [
            "name": name,
            "email": email,
            "createdAt": Timestamp(),
            "uid": uid
        ]
        
        Firestore.firestore().collection("users").document(uid).setData(document) { err in
            if let err = err {
                print("ユーザー情報のfirestoreへの保存に失敗: ", err)
                return
            }
            completion(true)
            print("ユーザー情報のfirestoreへの保存に成功")
        }
    }
    
    //Firestoreからユーザー情報を取得
    static func fetchUserFromFirestore(uid: String, completion: @escaping (User?) -> Void) {
        
        //addSnapshotListener: 情報の更新を自動で取得する
        Firestore.firestore().collection("users").document(uid).addSnapshotListener { (snapshot, err) in
            if let err = err {
                print("ユーザー情報の取得に失敗: ", err)
                completion(nil)
                return
            }
            //ユーザー情報を取得
            guard let dic = snapshot?.data() else { return }
            let user = User(dic: dic)
            completion(user)
        }
    }
    
    //Firestoreから自分以外のユーザー情報を取得
    static func fetchUserFromFirestore(completion: @escaping ([User]) -> Void) {
        
        Firestore.firestore().collection("users").getDocuments { (snapshots, err) in
            if let err = err {
                print("自分以外のユーザー情報の取得に失敗:", err)
                return
            }

            let users = snapshots?.documents.map({ (snapshot) -> User in
                let dic  = snapshot.data()
                let user = User(dic: dic)
                return user
            })
            
            //ログインユーザーの情報を除く
            let filteredUsers = users?.filter({ user in
                return user.uid != Auth.auth().currentUser?.uid
            })
            
            completion(filteredUsers ?? [User]())
        }
    }
    
    //既に存在するuidの情報を更新する
    static func updateUserInfo(dic: [String: Any], completion: @escaping () -> Void) {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        Firestore.firestore().collection("users").document(uid).updateData(dic) { (err) in
            if let err = err {
                print("ユーザー情報の更新に失敗: ", err)
                return
            }
            completion()
            print("ユーザー情報の更新に成功")
        }
    }
}

// MARK: - Storage
extension Storage {
    //StorageへImageを保存し、FirestoreのUser情報と紐付ける
    static func addProfileImageToStorage(image: UIImage, dic: [String: Any], completion: @escaping () -> Void) {
        
        //compressionQuality: 画像の解像度(0:データない→1:オリジナル)
        guard let uploadImage = image.jpegData(compressionQuality: 0.3) else { return }
        //ランダムな文字列を生成し、ファイルネームとして使用
        let fileName = NSUUID().uuidString
        let storageRef = Storage.storage().reference().child("profileImage").child(fileName)
        
        //画像をStorageに保存
        storageRef.putData(uploadImage, metadata: nil) { metadata, err in
            if let err = err {
                print("ProfileImageの保存に失敗: ", err)
                return
            }
            completion()
            
            //StorageからImageURLを取得しFirestoreへ保存
            storageRef.downloadURL { url, err in
                if let err = err {
                    print("画像URLの取得に失敗: ", err)
                    return
                }
                
                guard let urlString = url?.absoluteString else { return }
                var dicWithImage = dic
                dicWithImage["profileImageUrl"] = urlString
                
                Firestore.updateUserInfo(dic: dicWithImage) {
                    completion()
                }
            }

        }
    }
    
}

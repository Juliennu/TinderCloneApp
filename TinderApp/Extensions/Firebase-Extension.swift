//
//  Firebase-Extension.swift
//  TinderApp
//
//  Created by Juri Ohto on 2021/10/25.
//
import Firebase

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
}

// MARK: - Firestore
extension Firestore {
    
    //ViewControllerで処理の完了を受け取る(コールバック)
    static func setUserDataToFirestore(name: String?, email: String, uid: String, completion: @escaping (Bool) -> ()) {
        
        guard let name = name else { return }
        
        let document: [String: Any] = [
            "name": name,
            "email": email,
            "createdAt": Timestamp()
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
}

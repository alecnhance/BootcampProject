//
//  FirebaseViewModel.swift
//  WorkoutLog
//
//  Created by Alec Hance on 8/18/25.
//

import Foundation
import FirebaseFirestore

@Observable class FirebaseViewModel {
    static let vm = FirebaseViewModel()
    let db: Firestore
    
    private init() {
        db = Firestore.firestore()
    }
    
    func getLifts(userID: String) async -> [Lift] {
        let collectionRef = db.collection("USERS").document(userID).collection("LIFTS")
        
        do {
            let snapshot = try await collectionRef.getDocuments()
            
            let lifts: [Lift] = snapshot.documents.compactMap { doc in
                try? doc.data(as: Lift.self)
            }
            
            return lifts
        } catch {
            print("Error getting lifts: \(error.localizedDescription)")
            return []
        }
    }
    
    func addOrUpdateLift(lift: Lift, userID: String) async {
        let collectionRef = db.collection("USERS").document(userID).collection("LIFTS")
        
        do {
            try collectionRef.document(lift.id.uuidString).setData(from: lift, merge: true)
            print("Lift added or updated successfully")
        } catch {
            print("Error adding/updating lift: \(error.localizedDescription)")
        }
    }
    
    func removeLift(userID: String, liftID: String) async {
        do {
            print("liftID: \(liftID)")
            try await db.collection("USERS").document(userID).collection("LIFTS").document(liftID).delete()
        } catch {
            print("Error deleting lift")
        }
    }
    
    func readFromAlec() async -> Int {
        let docRef = db.collection("USER").document("Alec Hance")
        
        do {
            let document = try await docRef.getDocument()
            if document.exists {
                guard let iq = document.data()?["IQ"] as? Int else {
                    print("iq is not an int")
                    return -1
                }
                return iq
            } else {
                print("document doesn't exist")
                return -1
            }
        } catch {
            print("message")
            return -1
        }
    }
    
    func writeToBuzz(data: Int) async -> Bool {
        let ref = db.collection("USER").document("Buzz")
        
        do {
            try await ref.updateData([
                "IQ": data
            ])
            return true
        } catch {
            return false
        }
    }
}

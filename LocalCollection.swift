//
//  LocalCollection.swift
//  uguide
//
//  Created by Sebastian Frelle Koch on 4/22/18.
//  Copyright © 2018 Sebastian Frelle Koch. All rights reserved.
//

import FirebaseFirestore

protocol DocumentSerializable {
    init?(dictionary: [String: Any])
}

final class LocalCollection<T: DocumentSerializable> {
    private(set) var items: [T]
    private(set) var documents: [DocumentSnapshot] = []
    let query: Query
    
    private let updateHandler: ([DocumentChange]) -> ()
    
    private var listener: ListenerRegistration? {
        didSet {
            oldValue?.remove()
        }
    }
    
    var count: Int {
        return self.items.count
    }
    
    subscript(index: Int) -> T {
        return self.items[index]
    }
    
    init(query: Query, updateHandler: @escaping ([DocumentChange]) -> ()) {
        self.items = []
        self.query = query
        self.updateHandler = updateHandler
    }
    
    func index(of document: DocumentSnapshot) -> Int? {
        for i in 0..<documents.count {
            if documents[i].documentID == document.documentID {
                return i
            }
        }
        
        return nil
    }
    
    func listen() {
        guard listener == nil else { return }
        
        listener = query.addSnapshotListener { [unowned self] querySnapshot, error in
            guard let snapshot = querySnapshot else {
                print("Error fetching snapshot results: \(error!)")
                return
            }
            
            let models = snapshot.documents.map { (document) -> T in
                guard let model = T(dictionary: document.data()) else {
                    fatalError("Unable to initialize type \(T.self) with dictionary \(document.data())")
                }
                
                return model
            }

            self.items = models
            self.documents = snapshot.documents
            self.updateHandler(snapshot.documentChanges)
        }
    }
    
    func stopListening() {
        listener = nil
    }
    
    deinit {
        stopListening()
    }
}

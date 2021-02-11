//
//  DatabaseManager.swift
//  SwiftUITask02
//
//  Created by 高田 朋輝 on 2021/01/31.
//

import Foundation
import RealmSwift

class DatabaseManager: ObservableObject {

    private var realm: Realm
    private var itemResults: Results<Item>
    var items: [Item] {
        itemResults.map{ $0 }
    }

    init() {
        self.realm = try! Realm()
        itemResults = realm.objects(Item.self).sorted(byKeyPath: "createdAt", ascending: false)
    }
    
    func create(title: String, explanation: String) {
        objectWillChange.send()
        do {
            let realm = try Realm()
            let item = Item()
            item.title = title
            item.explanation = explanation
        
            try realm.write {
                realm.add(item)
            }
        } catch {
            print("Error saving item \(error)")
            return
        }
        return
    }
    
    func update(id: String, title: String, explanation: String) -> Bool {
        objectWillChange.send()
        do {
            try realm.write {
                let item = realm.objects(Item.self).filter("id = %@", id).first
                item?.title = title
                item?.explanation = explanation
            }
        } catch {
            print("Error deleting category, \(error)")
            return false
        }
        return true
    }
    
    func delete(id: String) -> Bool {
        objectWillChange.send()
        do {
            try realm.write {
                let item = realm.objects(Item.self).filter("id = %@", id)
                realm.delete(item)
            }
        } catch {
            print("Error deleting category, \(error)")
            return false
        }
        return true
    }
    
    func count() -> Int {
        return realm.objects(Item.self).count
    }
    
}

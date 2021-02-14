//
//  DatabaseManager.swift
//  SwiftUITask02
//
//  Created by 高田 朋輝 on 2021/01/31.
//

import Foundation
import RealmSwift
import WidgetKit

class DatabaseManager: ObservableObject {

    private var realm: Realm
    private var itemResults: Results<Item>
    var items: [Item] {
        itemResults.map{ $0 }
    }

    init() {
        var config = Realm.Configuration()
        let url = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.jp.kiroru.iOSWidgetKit")
        config.fileURL = url?.appendingPathComponent("db.realm")
        self.realm = try! Realm(configuration: config)
        itemResults = realm.objects(Item.self).sorted(byKeyPath: "createdAt", ascending: false)
    }
    
    func create(title: String, explanation: String) {
        objectWillChange.send()
        do {
            let item = Item()
            item.title = title
            item.explanation = explanation
        
            try realm.write {
                realm.add(item)
                WidgetCenter.shared.reloadAllTimelines()
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
                WidgetCenter.shared.reloadAllTimelines()
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
                WidgetCenter.shared.reloadAllTimelines()
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

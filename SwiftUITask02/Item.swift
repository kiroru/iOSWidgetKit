//
//  Item.swift
//  SwiftUITask02
//
//  Created by 高田 朋輝 on 2021/01/31.
//

import Foundation
import RealmSwift

class Item: Object, Identifiable {

    @objc dynamic var id: String = UUID().uuidString
    @objc dynamic var title: String = ""
    @objc dynamic var explanation: String = ""
    @objc dynamic var createdAt: Date = Date()

}


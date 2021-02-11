//
//  ItemView.swift
//  SwiftUITask02
//
//  Created by 高田 朋輝 on 2021/01/31.
//

import SwiftUI

struct ItemView: View {
    
    let item: Item
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(item.title)
            Text(item.explanation)
        }
    }

}

//
//  ContentView.swift
//  SwiftUITask02
//
//  Created by 高田 朋輝 on 2021/01/31.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var databaseManager: DatabaseManager
    
    init() {
        UINavigationBar.setAnimationsEnabled(false)
    }
    
    var body: some View {
        NavigationView {
            ScrollView() {
                LazyVStack(alignment: .leading) {
                    ForEach(databaseManager.items, id:\.self) { item in
                        NavigationLink(
                            destination: EditView(
                                id: item.id,
                                title: item.title,
                                explanation: item.explanation)
                                .environmentObject(databaseManager),
                            label: {
                                ItemView(item: item)
                            }
                        )
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(content: {
                ToolbarItem(placement: .principal) {
                    Text(NSLocalizedString("app_title", comment: ""))
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(
                        destination: EditView().environmentObject(databaseManager),
                        label: {
                            Image(systemName: "note.text.badge.plus")
                        }
                    )
                }
            })
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

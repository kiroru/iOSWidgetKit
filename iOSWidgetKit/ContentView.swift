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
            List {
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
                .onDelete(perform: deleteRow)
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

    func deleteRow(_ offsets: IndexSet) {
        guard let selectedIndex = offsets.first else {
            return
        }
        _ = databaseManager.delete(id: databaseManager.items[selectedIndex].id)
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

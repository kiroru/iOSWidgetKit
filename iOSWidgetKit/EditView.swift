//
//  EditView.swift
//  SwiftUITask02
//
//  Created by 高田 朋輝 on 2021/01/31.
//

import SwiftUI

struct EditView: View {

    @EnvironmentObject var databaseManager: DatabaseManager
    @Environment(\.presentationMode) var presentation
    var id: String?
    @State var title: String = ""
    @State var explanation: String = ""
    
    var body: some View {
        VStack {
            Spacer()
            VStack(spacing: 60) {
                Text(NSLocalizedString("title", comment: ""))
                TextField("", text: $title)
                    .frame(width: 200)
                Text(NSLocalizedString("explanation", comment: ""))
                TextField("", text: $explanation)
                    .frame(width: 200)
            }
            .textFieldStyle(RoundedBorderTextFieldStyle())
            Spacer()
            HStack() {
                Spacer()
                Button(NSLocalizedString("cancel", comment: "")) {
                    pressedCancel()
                }
                Spacer()
                Button(NSLocalizedString("ok", comment: "")) {
                    pressedOK()
                }
                Spacer()
            }
        }
        .navigationBarHidden(true)
    }
    
    func pressedOK() {
        if id == nil {
            create()
        }
        else {
            update()
        }
        presentation.wrappedValue.dismiss()
    }
    
    func pressedCancel() {
        presentation.wrappedValue.dismiss()
    }
    
    func create() {
        databaseManager.create(title: title, explanation: explanation)
    }
    
    func update() {
        _ = databaseManager.update(id: id!, title: title, explanation: explanation)
    }
    
}

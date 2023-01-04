//
//  NewGameForm.swift
//  Pokade
//
//  Created by Jona De Neve on 29/12/2022.
//

import SwiftUI

struct NewGameForm: View {
    @Environment(\.dismiss) var dismiss
    
    @Binding var squirdle: SquirdleViewModel
    
    var body: some View {
        if UIDevice.current.userInterfaceIdiom != .pad {
            Button("Close") {
                dismiss()
            }
        }
        Form {
            Section {
                TextField("Name", text: $squirdle.name)
            } header: {
                Text("Name")
            }
            Section {
                Text("To do")
            } header: {
                Text("Setting")
            }
            .navigationTitle(squirdle.name)
        }
    }
}

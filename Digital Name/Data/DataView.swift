//
//  DataView.swift
//  Digital Name
//
//  Created by Daniel Mandea on 10.07.2024.
//

import SwiftUI

struct DataView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    Text("provide_first_name_and_last_name")
                    .font(.headline)
                        .padding()
                    TextField("first_name_and_last_name", text: .constant(""))
                        .padding()
                }
                
                VStack(alignment: .leading) {
                    Text("languages")
                        LanguageItemView(name: "Germany", image: "Germany", isOn: .constant(true))
                        LanguageItemView(name: "Turky", image: "Turky", isOn: .constant(true))
                        LanguageItemView(name: "United Kyndom", image: "UI", isOn: .constant(true))
                }
                .padding()
            }
            .navigationTitle("data_entry_title")
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbarBackground(.gray, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbar {
                ToolbarItem {
                    Button(action: save) {
                        Text("Save")
                    }
                }
            }

        }
    }
    
    private func save() {
        withAnimation {
            dismiss()
        }
    }
}

#Preview {
    DataView()
}

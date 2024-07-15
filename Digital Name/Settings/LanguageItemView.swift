//
//  LanguageItemView.swift
//  Digital Name
//
//  Created by Daniel Mandea on 09.07.2024.
//

import SwiftUI

struct LanguageItemView: View {
    
    // MARK: - Properties
    
    let language: Language
    @Binding var isOn: Bool

    // MARK: - Body

    var body: some View {
        HStack {
            Text(language.icon)
                .font(.title2)
                .bold()
            Toggle(language.description, isOn: $isOn)
                .tint(.tkCyan)
                .font(.title2)
                .bold()
        }
        .padding(.horizontal, 8)
    }
}

#Preview {
    LanguageItemView(language: .greek, isOn: .constant(true))
}

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
        let title2 = Font.custom("SoletoTK-Bold", size: 22)

        HStack {
            Image(language.icon)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 60, height: 60)
            Toggle(language.description, isOn: $isOn)
                .tint(.tkCyan)
                .font(title2)
        }
        .padding(.horizontal, 8)
    }
}

#Preview {
    LanguageItemView(language: .greek, isOn: .constant(true))
}

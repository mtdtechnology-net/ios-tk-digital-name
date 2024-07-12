//
//  LanguageItemView.swift
//  Digital Name
//
//  Created by Daniel Mandea on 09.07.2024.
//

import SwiftUI

struct LanguageItemView: View {
    
    var name: String
    var image: String
    @Binding var isOn: Bool

    var body: some View {
        HStack {
            Image("Germany")
                .resizable()
                .frame(maxWidth: 30, maxHeight: 30)
            Toggle(name, isOn: $isOn)
        }
    }
}

#Preview {
    LanguageItemView(name: "Germnay", image: "Germany", isOn: .constant(true))
}

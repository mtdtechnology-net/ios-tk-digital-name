//
//  SettingsView.swift
//  Digital Name
//
//  Created by Marcel on 15.07.2024.
//

import SwiftUI

struct SettingsView: View {

    // MARK: - Properties

    // MARK: - Body

    var body: some View {
        VStack {
            HStack {
                Text("settings".localized)
                    .font(.title)
                    .foregroundStyle(.white)
                    .bold()
                    .padding()
                Spacer()
            }
            .frame(maxHeight: 80)
            .background(.tkDunkelGrau)

            Spacer()

            VStack(spacing: 20) {
                Text("settings_description".localized)
                    .multilineTextAlignment(.center)
                    .font(.title)
                Button(action: {
                    openAppSettings()
                }) {
                    Text("change_language".localized)
                        .font(.title2)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(.tkCyan)
                        .foregroundStyle(.white)
                        .cornerRadius(10)
                        .padding(.horizontal)
                }
                .padding(.bottom, 20)

                Spacer()
            }
            .padding()
        }
    }

    private func openAppSettings() {
        if let url = URL(string: UIApplication.openSettingsURLString) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }
}

#Preview {
    SettingsView()
}

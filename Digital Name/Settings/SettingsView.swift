//
//  SettingsView.swift
//  Digital Name
//
//  Created by Marcel on 15.07.2024.
//

import SwiftUI

struct SettingsView: View {

    // MARK: - Properties

    @AppStorage("languageSelections") private var languageSelectionsData: Data?
    @AppStorage("person") private var person: String?
    @AppStorage("email") private var emailCache: String?
    @AppStorage("phone") private var phoneCache: String?
    @AppStorage("position") private var positionCache: String?
    var hasTappedOnClear: () -> Void
    @Environment(\.dismiss) var dismiss

    // MARK: - Body

    var body: some View {
        VStack {
            HStack {
                Text("settings".localized)
                    .font(.title)
                    .foregroundStyle(.tkDunkelGrau)
                    .bold()
                    .padding(.leading, 25)
                Spacer()
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "x.circle")
                        .font(.title)
                        .bold()
                        .foregroundStyle(.tkDunkelGrau)
                }
                .padding(.trailing, 25)
            }
            .frame(height: 80)
            .background(.white)

            Rectangle()
                .fill(.tkHellgrau)
                .frame(maxWidth: .infinity)
                .frame(height: 1)
                .shadow(color: .black.opacity(0.3), radius: 2, y: 3)

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
                .padding(.bottom, 50)

                /// Action to clear the cache
                Text("cache_description".localized)
                    .multilineTextAlignment(.center)
                    .font(.title)
                Button(action: {
                    clearCache()
                }) {
                    Text("clear_cache".localized)
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
        .background(.white)
    }

    private func openAppSettings() {
        if let url = URL(string: UIApplication.openSettingsURLString) {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
    }

    private func clearCache() {
        languageSelectionsData = nil
        person = nil
        emailCache = nil
        phoneCache = nil
        positionCache = nil
        hasTappedOnClear()
    }
}

#Preview {
    SettingsView { }
}

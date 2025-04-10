//
//  DataEntryView.swift
//  Digital Name
//
//  Created by Daniel Mandea on 10.07.2024.
//

import SwiftUI

struct DataEntryView: View {

    // MARK: - Properties

    @Environment(\.dismiss) var dismiss
    @AppStorage("languageSelections") private var languageSelectionsData: Data = Data()
    @AppStorage("person") private var person: String = ""
    @AppStorage("email") private var emailCache: String = ""
    @AppStorage("phone") private var phoneCache: String = ""
    @AppStorage("position") private var positionCache: String = ""
    @Binding var languageSelections: [String: Bool]
    @Binding var phone: String
    @Binding var email: String
    @Binding var position: String
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @State private var isShowingSettings = false

    // MARK: - Body

    var body: some View {
        let isCompact = horizontalSizeClass == .compact
        let title2 = Font.custom("SoletoTK-Bold", size: 22)
        let title3 = Font.custom("SoletoTK-Bold", size: 20)
        let title = Font.custom("SoletoTK-Bold", size: 28)
        let largeTitle = Font.custom("SoletoTK-Bold", size: 34)

        VStack {
            HStack {
                Text("data_entry".localized)
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundStyle(.tkDunkelGrau)
                Spacer()
                Button {
                    save()
                } label: {
                    Text("save".localized)
                        .font(isCompact ? title2 : title)
                }
                .foregroundStyle(.tkCyan)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 80)
            .padding(.horizontal, 25)
            .background(.white)

            Rectangle()
                .fill(.tkHellgrau)
                .frame(maxWidth: .infinity)
                .frame(height: 1)
                .shadow(color: .black.opacity(0.3), radius: 2, y: 3)

            ScrollView {
                VStack(alignment: .leading) {
                    Text("info_description".localized)
                        .font(isCompact ? title : largeTitle)
                        .foregroundStyle(.tkMittlegrau)
                        .padding([.top, .bottom], isCompact ? 10 : 20)
                    VStack(alignment: .leading, spacing: 15) {
                        /// Person name
                        Text("provide_first_name_and_last_name".localized)
                            .font(isCompact ? title2 : largeTitle)
                            .foregroundStyle(.tkCyan)
                        TextField("enter_name_here".localized, text: $person)
                            .padding([.top, .bottom], isCompact ? 10 : 20)
                            .padding(.leading, 10)
                            .font(isCompact ? title3 : title2)
                            .foregroundStyle(.tkDunkelGrau)
                            .autocorrectionDisabled()
                            .textInputAutocapitalization(.words)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(.tkCyan, lineWidth: 2)
                            )
                        /// Person phone
                        Text("provide_phone".localized)
                            .font(isCompact ? title2 : largeTitle)
                            .foregroundStyle(.tkCyan)
                        TextField("enter_phone_here".localized, text: $phone)
                            .padding([.top, .bottom], isCompact ? 10 : 20)
                            .padding(.leading, 10)
                            .font(isCompact ? title3 : title2)
                            .foregroundStyle(.tkDunkelGrau)
                            .autocorrectionDisabled()
                            .keyboardType(.phonePad)
                            .textInputAutocapitalization(.never)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(.tkCyan, lineWidth: 2)
                            )

                        /// Person email address
                        Text("provide_email".localized)
                            .font(isCompact ? title2 : largeTitle)
                            .foregroundStyle(.tkCyan)
                        TextField("enter_email_here".localized, text: $email)
                            .padding([.top, .bottom], isCompact ? 10 : 20)
                            .padding(.leading, 10)
                            .font(isCompact ? title3 : title2)
                            .foregroundStyle(.tkDunkelGrau)
                            .autocorrectionDisabled()
                            .keyboardType(.emailAddress)
                            .textInputAutocapitalization(.never)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(.tkCyan, lineWidth: 2)
                            )

                        /// Person position
                        Text("provide_position".localized)
                            .font(isCompact ? title2 : largeTitle)
                            .foregroundStyle(.tkCyan)
                        TextField("enter_position_here".localized, text: $position)
                            .padding([.top, .bottom], isCompact ? 10 : 20)
                            .padding(.leading, 10)
                            .font(isCompact ? title3 : title2)
                            .foregroundStyle(.tkDunkelGrau)
                            .autocorrectionDisabled()
                            .textInputAutocapitalization(.never)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(.tkCyan, lineWidth: 2)
                            )
                    }
                }
                .padding()

                VStack(alignment: .leading) {
                    Text("choose_languages".localized)
                        .font(isCompact ? title2 : largeTitle)
                        .foregroundStyle(.tkCyan)
                    ForEach(Language.allCases) { language in
                        LanguageItemView(language: language, isOn: self.binding(for: language))
                    }
                }
                .padding()

                
                Button {
                    isShowingSettings = true
                } label: {
                    Text("Open Settings")
                        .font(isCompact ? title2 : title)
                        .foregroundStyle(.white)
                        .padding()
                        .background(.tkCyan)
                        .cornerRadius(10)

                    Spacer()
                }
                .padding()

            }
            .padding(.bottom, isCompact ? 10 : 20)
            .onAppear(perform: load)
        }
        .background(.white)
        .sheet(isPresented: $isShowingSettings) {
            SettingsView(hasTappedOnClear: {
                languageSelections = [:]
                email = ""
                phone = ""
                position = ""
            })
        }
    }

    private func binding(for language: Language) -> Binding<Bool> {
        Binding<Bool>(
            get: { self.languageSelections[language.icon] ?? false },
            set: { self.languageSelections[language.icon] = $0 }
        )
    }

    private func save() {
        withAnimation {
            if let data = try? JSONEncoder().encode(languageSelections) {
                languageSelectionsData = data
            }
            dismiss()
        }
    }

    private func load() {
        if let savedSelections = try? JSONDecoder().decode([String: Bool].self, from: languageSelectionsData) {
            languageSelections = savedSelections
        }
    }
}

#Preview {
    DataEntryView(languageSelections: .constant(["🏴󠁧󠁢󠁥󠁮󠁧󠁿": false]), phone: .constant("074878581"), email: .constant("Email"), position: .constant("Director"))
}

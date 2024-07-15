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
    @State private var languageSelections: [String: Bool] = [:]

    // MARK: - Body

    var body: some View {
        VStack{
            HStack {
                Text("data_entry".localized)
                    .font(.title)
                    .foregroundStyle(.white)
                    .bold()
                    .padding()
                Spacer()
                Button {
                    save()
                } label: {
                    Text("save".localized)
                        .font(.title2)
                        .bold()
                }
                .padding()
            }
            .frame(maxHeight: 80)
            .background(.tkDunkelGrau)
            ScrollView {
                VStack(alignment: .leading) {
                    Text("info_description".localized)
                        .bold()
                        .font(.largeTitle)
                        .foregroundStyle(.tkMittlegrau)
                        .padding([.top, .bottom], 20)
                    VStack(alignment: .leading) {
                        Text("provide_first_name_and_last_name".localized)
                            .bold()
                            .font(.largeTitle)
                            .foregroundStyle(.tkCyan)
                        TextField("enter_name_here".localized, text: $person)
                            .bold()
                            .font(.title2)
                            .foregroundStyle(.tkDunkelGrau)
                            .padding(.leading, 5)
                            .autocorrectionDisabled()
                            .textInputAutocapitalization(.words)
                    }
                }
                .padding()

                VStack(alignment: .leading) {
                    Text("choose_languages".localized)
                        .bold()
                        .font(.largeTitle)
                        .foregroundStyle(.tkCyan)
                    ForEach(Language.allCases) { language in
                        LanguageItemView(language: language, isOn: self.binding(for: language))
                    }
                }
                .padding()
            }
            .padding(.bottom, 20)
            .onAppear(perform: load)
        }
    }

    private func binding(for language: Language) -> Binding<Bool> {
        Binding<Bool>(
            get: { self.languageSelections[language.rawValue] ?? false },
            set: { self.languageSelections[language.rawValue] = $0 }
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
    DataEntryView()
}

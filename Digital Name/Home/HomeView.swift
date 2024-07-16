//
//  HomeView.swift
//  Digital Name
//
//  Created by Daniel Mandea on 08.07.2024.
//

import SwiftUI
import SwiftData

struct HomeView: View {

    // MARK: - Properties

    @AppStorage("languageSelections") private var languageSelectionsData: Data?
    @State private var languageSelections: [String: Bool] = [:]
    @State private var phone: String = ""
    @State private var email: String = ""
    @State private var position: String = ""
    @AppStorage("person") private var person: String?
    @State private var showingSettingsSheet = false
    @State private var showingDataEntrySheet = false
    @State private var orientation = UIDevice.current.orientation

    // MARK: - Body

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image("TK")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .padding(.leading, 40)
                    .padding(.top, 80)
                Spacer()
                HStack(spacing: 10) {
                    Button {
                        showingDataEntrySheet.toggle()
                    } label: {
                        Image(systemName: "person.text.rectangle")
                            .resizable()
                            .foregroundColor(.white)
                            .frame(width: 60, height: 40)
                    }
                    .padding()

                    Button {
                        showingSettingsSheet.toggle()
                    } label: {
                        Image(systemName: "gearshape.fill")
                            .resizable()
                            .foregroundColor(.white)
                            .frame(width: 40, height: 40)
                    }
                    .padding()
                }
            }
            .frame(maxHeight: 80)
            .background(.tkDunkelGrau)

            GeometryReader { geometry in
                if geometry.size.width > geometry.size.height {
                    /// LANDSCAPE
                    HStack {
                        Image("SmartPhone")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding([.top, .leading, .trailing], 50)

                        VStack(alignment: .leading) {
                            if let person = person, person != "" {
                                VStack(alignment: .leading, spacing: 10) {
                                    Text(person)
                                        .font(.system(size: 50))
                                        .bold()
                                    Text("greeting".localized)
                                        .font(.system(size: 20))
                                        .italic()
                                }
                                .padding()
                            }
                            if !languageSelections.isEmpty {
                                HStack {
                                    ForEach(Array(languageSelections), id: \.key) { language in
                                        if language.value {
                                            Text(language.key)
                                                .font(.system(size: 50))
                                        }
                                    }
                                }
                                .padding(.top, 5)
                            }

                            if phone != "" {
                                HStack(spacing: 20) {
                                    Image(systemName: "phone")
                                    Text(phone)
                                }
                                .foregroundStyle(.tkWarmesGrau)
                                .font(.system(size: 35))
                            }

                            if email != "" {
                                HStack(spacing: 20) {
                                    Image(systemName: "envelope")
                                    Text(email)
                                }
                                .foregroundStyle(.tkWarmesGrau)
                                .font(.system(size: 35))
                            }

                            if position != "" {
                                HStack(spacing: 20) {
                                    Image(systemName: "person.badge.shield.checkmark")
                                    Text(position)
                                }
                                .foregroundStyle(.tkWarmesGrau)
                                .font(.system(size: 35))
                            }
                        }
                    }
                } else {
                    /// PORTRAIT
                    VStack(alignment: .leading) {
                        Image("SmartPhone")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(.all, 50)

                        if let person = person, person != "" {
                            VStack(alignment: .leading, spacing: 10) {
                                Text(person)
                                    .font(.system(size: 50))
                                    .bold()
                                Text("greeting".localized)
                                    .font(.system(size: 35))
                                    .italic()
                            }
                            .padding(.leading, 50)
                        }

                        if !languageSelections.isEmpty {
                            HStack {
                                ForEach(Array(languageSelections), id: \.key) { language in
                                    if language.value {
                                        Text(language.key)
                                            .font(.system(size: 50))
                                    }
                                }
                            }
                            .padding(.top, 5)
                            .padding(.leading, 50)
                        }

                        if phone != "" {
                            HStack(spacing: 20) {
                                Image(systemName: "phone")
                                Text(phone)
                            }
                            .foregroundStyle(.tkWarmesGrau)
                            .font(.system(size: 35))
                            .padding(.leading, 50)
                        }

                        if email != "" {
                            HStack(spacing: 20) {
                                Image(systemName: "envelope")
                                Text(email)
                            }
                            .foregroundStyle(.tkWarmesGrau)
                            .font(.system(size: 35))
                            .padding(.leading, 50)
                        }

                        if position != "" {
                            HStack(spacing: 20) {
                                Image(systemName: "person.badge.shield.checkmark")
                                Text(position)
                            }
                            .foregroundStyle(.tkWarmesGrau)
                            .font(.system(size: 35))
                            .padding(.leading, 50)
                        }
                    }
                }
            }
            Spacer()
        }
        .background(.tkHellgrau)
        .onAppear {
            load()
            NotificationCenter.default.addObserver(forName: UIDevice.orientationDidChangeNotification, object: nil, queue: .main) { _ in
                self.orientation = UIDevice.current.orientation
            }
        }
        .sheet(isPresented: $showingDataEntrySheet) {
            DataEntryView(
                languageSelections: $languageSelections,
                phone: $phone,
                email: $email,
                position: $position
            )
        }
        .sheet(isPresented: $showingSettingsSheet) {
            SettingsView {
                languageSelections = [:]
            }
        }
    }

    // MARK: - Private methods

    private func load() {
        if let languageSelectionsData = languageSelectionsData,
           let savedSelections = try? JSONDecoder().decode([String: Bool].self, from: languageSelectionsData) {
            languageSelections = savedSelections
        }
    }

    private func showSetting() {
        withAnimation {
            showingSettingsSheet.toggle()
        }
    }

    private func showDataEntry() {
        withAnimation {
            showingDataEntrySheet.toggle()
        }
    }
}

#Preview {
    HomeView()
}

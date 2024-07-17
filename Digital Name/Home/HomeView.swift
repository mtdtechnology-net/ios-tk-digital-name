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
    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    // MARK: - Body

    var body: some View {
        VStack(alignment: .leading) {
            let isCompact = horizontalSizeClass == .compact
            let width = isCompact ? 50 : 100
            let height = isCompact ? 50 : 100
            let leadingPadding = isCompact ? 20 : 40
            let topPadding = isCompact ? 40 : 80

            HStack {
                Image("TK")
                    .resizable()
                    .frame(width: CGFloat(width), height: CGFloat(height))
                    .padding(.leading, CGFloat(leadingPadding))
                    .padding(.top, CGFloat(topPadding))
                Spacer()
                HStack(spacing: 10) {
                    Button {
                        showingDataEntrySheet.toggle()
                    } label: {
                        Image(systemName: "person.text.rectangle")
                            .resizable()
                            .foregroundColor(.white)
                            .frame(width: isCompact ? 30 : 60,
                                   height: isCompact ? 20 : 40)
                    }
                    .padding()

                    Button {
                        showingSettingsSheet.toggle()
                    } label: {
                        Image(systemName: "gearshape.fill")
                            .resizable()
                            .foregroundColor(.white)
                            .frame(width:  CGFloat(leadingPadding),
                                   height:  CGFloat(leadingPadding))
                    }
                    .padding()
                }
            }
            .frame(maxHeight: CGFloat(topPadding))
            .background(.tkDunkelGrau)

            GeometryReader { geometry in
                if geometry.size.width > geometry.size.height {
                    /// LANDSCAPE
                    HStack {
                        Image("SmartPhone")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding([.top, .leading, .trailing], isCompact ? 25 : 50)

                        VStack(alignment: .leading) {
                            if let person = person, person != "" {
                                VStack(alignment: .leading, spacing: 10) {
                                    Text(person)
                                        .font(.system(size: isCompact ? 25 : 50))
                                        .bold()
                                    Text("greeting".localized)
                                        .font(.system(size: isCompact ? 10 : 20))
                                        .italic()
                                }
                                .padding()
                            }
                            if !languageSelections.isEmpty {
                                HStack {
                                    ForEach(Array(languageSelections), id: \.key) { language in
                                        if language.value {
                                            Text(language.key)
                                                .font(.system(size: isCompact ? 25 : 50))
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
                                .font(.system(size: isCompact ? 17 : 35))
                            }

                            if email != "" {
                                HStack(spacing: 20) {
                                    Image(systemName: "envelope")
                                    Text(email)
                                }
                                .foregroundStyle(.tkWarmesGrau)
                                .font(.system(size: isCompact ? 17 : 35))
                            }

                            if position != "" {
                                HStack(spacing: 20) {
                                    Image(systemName: "person.badge.shield.checkmark")
                                    Text(position)
                                }
                                .foregroundStyle(.tkWarmesGrau)
                                .font(.system(size: isCompact ? 17 : 35))
                            }
                        }
                    }
                } else {
                    /// PORTRAIT
                    VStack(alignment: .leading) {
                        Image("SmartPhone")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(.all, isCompact ? 25 : 50)
                            .frame(width: UIScreen.main.bounds.width)

                        if let person = person, person != "" {
                            VStack(alignment: .leading, spacing: 10) {
                                Text(person)
                                    .font(.system(size: isCompact ? 25 : 50))
                                    .bold()
                                Text("greeting".localized)
                                    .font(.system(size: isCompact ? 17 : 35))
                                    .italic()
                            }
                            .padding(.leading, isCompact ? 25 : 50)
                        }

                        if !languageSelections.isEmpty {
                            HStack {
                                ForEach(Array(languageSelections), id: \.key) { language in
                                    if language.value {
                                        Text(language.key)
                                            .font(.system(size: isCompact ? 25 : 50))
                                    }
                                }
                            }
                            .padding(.top, 5)
                            .padding(.leading, isCompact ? 25 : 50)
                        }

                        if phone != "" {
                            HStack(spacing: 20) {
                                Image(systemName: "phone")
                                Text(phone)
                            }
                            .foregroundStyle(.tkWarmesGrau)
                            .font(.system(size: isCompact ? 17 : 35))
                            .padding(.top, isCompact ? 5 : 10)
                            .padding(.leading, isCompact ? 25 : 50)
                        }

                        if email != "" {
                            HStack(spacing: 20) {
                                Image(systemName: "envelope")
                                Text(email)
                            }
                            .foregroundStyle(.tkWarmesGrau)
                            .font(.system(size: isCompact ? 17 : 35))
                            .padding(.top, isCompact ? 5 : 10)
                            .padding(.leading, isCompact ? 25 : 50)
                        }

                        if position != "" {
                            HStack(spacing: 20) {
                                Image(systemName: "person.badge.shield.checkmark")
                                Text(position)
                            }
                            .foregroundStyle(.tkWarmesGrau)
                            .font(.system(size: isCompact ? 17 : 35))
                            .padding(.top, isCompact ? 5 : 10)
                            .padding(.leading, isCompact ? 25 : 50)
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
                email = ""
                phone = ""
                position = ""
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

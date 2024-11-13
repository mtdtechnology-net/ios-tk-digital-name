//
//  HomeView.swift
//  Digital Name
//
//  Created by Daniel Mandea on 08.07.2024.
//

import SwiftUI

struct HomeView: View {

    // MARK: - Properties

    @AppStorage("languageSelections") private var languageSelectionsData: Data?
    @State private var languageSelections: [String: Bool] = [:]
    @State private var phone: String = ""
    @State private var email: String = ""
    @State private var position: String = ""
    @AppStorage("person") private var person: String?
    @State private var showingDataEntrySheet = false
    @State private var orientation = UIDevice.current.orientation
    @Environment(\.horizontalSizeClass) var horizontalSizeClass

    // MARK: - Body

    var body: some View {
        let title2 = Font.custom("SoletoTK-Medium", size: 30)
        let title3 = Font.custom("SoletoTK-Medium", size: 20)
        let title = Font.custom("SoletoTK-Bold", size: 25)
        let largeTitle = Font.custom("SoletoTK-Bold", size: 50)
        let title17 = Font.custom("SoletoTK-Bold", size: 17)
        let title35 = Font.custom("SoletoTK-Bold", size: 35)
        let welcomeFont = Font.custom("SoletoTK-Medium", size: 70)

        VStack {
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
                        Image("profile")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundStyle(.black.opacity(0.6))
                            .frame(
                                width: isCompact ? 30 : 50,
                                height: isCompact ? 30 : 50
                            )
                    }
                    .padding()
                }
            }
            .frame(height: CGFloat(topPadding))
            .background(.white)
            .shadow(color: .black.opacity(0.3), radius: 3, y: 5)

            GeometryReader { geometry in
                if geometry.size.width > geometry.size.height {
                    /// LANDSCAPE
                    HStack(alignment: .top) {
                        VStack(alignment: .leading) {
                            Text("welcome".localized)
                                .font(isCompact ? largeTitle : welcomeFont)
                                .foregroundStyle(.tkCyan)
                                .padding(.top, 70)
                                .padding(.bottom, 35)
                                .padding(.horizontal)

                            if let person = person, person != "" {
                                VStack(alignment: .leading, spacing: 5) {
                                    Text("greeting".localized)
                                        .font(isCompact ? title3 : title2)
                                        .kerning(5)
                                        .padding(.bottom, 5)
                                    Text(person)
                                        .font(isCompact ? title : largeTitle)
                                }
                                .foregroundStyle(.tkDunkelGrau)
                                .padding(.horizontal)
                            }
                            if !languageSelections.isEmpty {
                                let selectedLanguages = languageSelections.filter { $0.value }.map { $0.key }
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 30) {
                                        ForEach(selectedLanguages.indices, id: \.self) { index in
                                            Image(selectedLanguages[index])
                                                .resizable()
                                                .frame(width: 70, height: 50)
                                        }
                                        Spacer()
                                    }
                                }
                                .padding(.horizontal)
                            }

                            if phone != "" {
                                HStack(spacing: 20) {
                                    Image(systemName: "phone")
                                    Text(phone)
                                }
                                .foregroundStyle(.tkWarmesGrau)
                                .font(isCompact ? title17 : title35)
                                .padding(.horizontal)
                            }

                            if email != "" {
                                HStack(spacing: 20) {
                                    Image(systemName: "envelope")
                                    Text(email)
                                }
                                .foregroundStyle(.tkWarmesGrau)
                                .font(isCompact ? title17 : title35)
                                .padding(.horizontal)
                            }

                            if position != "" {
                                HStack(spacing: 20) {
                                    Image(systemName: "person.badge.shield.checkmark")
                                    Text(position)
                                }
                                .foregroundStyle(.tkWarmesGrau)
                                .font(isCompact ? title17 : title35)
                                .padding(.horizontal)
                            }
                        }
                        .padding(.top, isCompact ? 25 : 50)
                        .padding(.horizontal, 30)

                        Spacer()
                    }
                } else {
                    /// PORTRAIT
                    VStack(alignment: .leading) {
                        VStack(alignment: .leading) {
                            Text("welcome".localized)
                                .font(isCompact ? largeTitle : welcomeFont)
                                .foregroundStyle(.tkCyan)
                                .padding(.top, 100)
                                .padding(.bottom, 50)

                            if let person = person, person != "" {
                                VStack(alignment: .leading, spacing: 10) {
                                    Text("greeting".localized)
                                        .font(isCompact ? title3 : title2)
                                        .kerning(5)
                                        .padding([.top, .bottom], 10)
                                    Text(person)
                                        .font(isCompact ? title : largeTitle)
                                }
                                .foregroundStyle(.tkDunkelGrau)
                            }

                            if !languageSelections.isEmpty {
                                let selectedLanguages = languageSelections.filter { $0.value }.map { $0.key }
                                ScrollView(.horizontal, showsIndicators: false) {
                                    HStack(spacing: 30) {
                                        ForEach(selectedLanguages.indices, id: \.self) { index in
                                            Image(selectedLanguages[index])
                                                .resizable()
                                                .frame(width: 70, height: 50)
                                        }
                                        Spacer()
                                    }
                                }
                                .padding([.top, .bottom], 10)
                            }

                            if phone != "" {
                                HStack(spacing: 20) {
                                    Image(systemName: "phone")
                                    Text(phone)
                                }
                                .foregroundStyle(.tkWarmesGrau)
                                .font(isCompact ? title17 : title35)
                            }

                            if email != "" {
                                HStack(spacing: 20) {
                                    Image(systemName: "envelope")
                                    Text(email)
                                }
                                .foregroundStyle(.tkWarmesGrau)
                                .font(isCompact ? title17 : title35)
                            }

                            if position != "" {
                                HStack(spacing: 20) {
                                    Image(systemName: "person.badge.shield.checkmark")
                                    Text(position)
                                }
                                .foregroundStyle(.tkWarmesGrau)
                                .font(isCompact ? title17 : title35)
                            }
                        }
                        .padding(.horizontal, isCompact ? 25 : 80)
                    }
                }
            }
            Spacer()
        }
        .background(.white)
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
    }

    // MARK: - Private methods

    private func load() {
        if let languageSelectionsData = languageSelectionsData,
           let savedSelections = try? JSONDecoder().decode([String: Bool].self, from: languageSelectionsData) {
            languageSelections = savedSelections
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

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

    @AppStorage("person") private var person: String?
    @State private var showingSettingsSheet = false
    @State private var showingDataEntrySheet = false
    @Environment(\.verticalSizeClass) var verticalSizeClass

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
            HStack {
                if verticalSizeClass != .compact {
                    VStack {
                        Spacer()
                        Image("SmartPhone")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding([.top, .bottom], 20)
                            .padding(.leading, 40)
                        Spacer()
                    }
                }
                if let person = person {
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

                Spacer()
            }
            .background(.tkHellgrau)
            .padding([.top, .bottom], 60)
        }
        .sheet(isPresented: $showingDataEntrySheet) {
            DataEntryView()
        }
        .sheet(isPresented: $showingSettingsSheet) {
            SettingsView()
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

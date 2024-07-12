//
//  HomeView.swift
//  Digital Name
//
//  Created by Daniel Mandea on 08.07.2024.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    
    @Environment(\.modelContext) private var modelContext
    @State private var showingSheet = false
    
    @Environment(\.verticalSizeClass) var verticalSizeClass
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image("TK")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .padding(.leading, 40)
                    .padding(.top, 80)
                Spacer()
                Button {
                    showingSheet.toggle()
                } label: {
                    Image(systemName: "gearshape")
                        .resizable()
                        .foregroundColor(.white)
                        .frame(width: 40, height: 40)
                }
                
                .padding()
            }
            .frame(maxHeight: 80)
            .background(.gray)
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
                VStack(alignment: .leading) {
                    Text("welcome_title")
                        .font(.title)
                    Text("person_name")
                        .font(.system(size: 90))
                }
                .padding()
                Spacer()
            }
            .background(.tkLightGray)
            .padding([.top, .bottom], 60)
        }
        .toolbar {
            ToolbarItem {
                Button(action: showSetting) {
                    Label("Settings", systemImage: "gearshape")
                }
            }
        }
        .navigationBarHidden(true)
        .sheet(isPresented: $showingSheet) {
            DataView()
        }
    }
    
    private func showSetting() {
        withAnimation {
            showingSheet.toggle()
        }
    }
}

#Preview {
    HomeView()
}

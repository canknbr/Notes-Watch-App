//
//  DetailView.swift
//  Notes Watch App
//
//  Created by Can Kanbur on 31.05.2023.
//

import SwiftUI

struct DetailView: View {
    let note: Note
    let count: Int
    let index: Int
    @State var isCreditShow = false
    @State var isSettingsShow = false
    
    var body: some View {
        VStack(alignment: .center, spacing: 4) {
            HeaderView(title: "")
            Spacer()
            ScrollView(.vertical, showsIndicators: false) {
                Text(note.text)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)
            }
            Spacer()
            HStack(alignment: .center) {
                Image(systemName: "gear")
                    .imageScale(.large)
                    .onTapGesture {
                        isSettingsShow.toggle()
                    }
                    .sheet(isPresented: $isSettingsShow) {
                        SettingsView()
                    }
                Spacer()
                Text("\(count) / \(index + 1) ")
                Spacer()
                Image(systemName: "info.circle")
                    .imageScale(.large)
                    .onTapGesture {
                        isCreditShow.toggle()
                    }.sheet(isPresented: $isCreditShow) {
                        CreditsView()
                    }
            }.foregroundColor(.secondary)
        }
        .padding(3)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var sample: Note = Note(id: UUID(), text: "test")
    static var previews: some View {
        DetailView(note: sample, count: 5, index: 1)
    }
}

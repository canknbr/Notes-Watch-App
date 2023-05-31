//
//  SettingsView.swift
//  Notes Watch App
//
//  Created by Can Kanbur on 31.05.2023.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("lineCount") var lineCount = 1
    @State var value: Float = 1.0
    func update() {
        lineCount = Int(value)
    }

    var body: some View {
        VStack(spacing: 8) {
            HeaderView(title: "Settings")
            Text("Lines : \(lineCount)".uppercased())
                .bold()
            Slider(value: Binding(get: {
                self.value
            }, set: { newValue in
                self.value = newValue
                self.update()
            }), in: 1 ... 4, step: 1)
                .tint(.accentColor)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

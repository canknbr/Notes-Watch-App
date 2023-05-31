//
//  CreditsView.swift
//  Notes Watch App
//
//  Created by Can Kanbur on 31.05.2023.
//

import SwiftUI

struct CreditsView: View {
    @State var randomNumber : Int = Int.random(in: 1..<4)
    var randomImage : String {
        return "developer-no\(randomNumber)"
    }
    var body: some View {
        VStack(spacing: 4) {
            Image(randomImage)
                .resizable()
                .scaledToFit()
                .layoutPriority(1)
            HeaderView(title: "Credits")
            Text("Cam Kanbur")
                .foregroundColor(.primary)
                .bold()
            
            Text("Developer")
                .font(.footnote)
                .foregroundColor(.secondary)
                .fontWeight(.light)
        }
    }
}

struct CreditsView_Previews: PreviewProvider {
    static var previews: some View {
        CreditsView()
    }
}

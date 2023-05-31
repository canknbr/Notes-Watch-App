//
//  ContentView.swift
//  Notes Watch App
//
//  Created by Can Kanbur on 31.05.2023.
//

import SwiftUI

struct ContentView: View {
    @State var text = ""
    @State var notes: [Note] = []
    @AppStorage("lineCount") var lineCount = 1
    func getDocumentDirectory() -> URL {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return path[0]
    }

    func save() {
        do {
            let data = try JSONEncoder().encode(notes)
            let url = getDocumentDirectory().appendingPathComponent("notes")
            try data.write(to: url)
        } catch {
            fatalError("error")
        }
    }

    func load() {
        DispatchQueue.main.async {
            do {
                let url = getDocumentDirectory().appendingPathComponent("notes")
                let data = try Data(contentsOf: url)

                notes = try JSONDecoder().decode([Note].self, from: data)

            } catch {
                
            }
        }
    }
    func delete(offsets: IndexSet){
        withAnimation {
            notes.remove(atOffsets: offsets)
            save()
        }
    }

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Add new note", text: $text)
                    Button {
                        guard text.isEmpty == false else { return }
                        let note = Note(id: UUID(), text: text)
                        notes.append(note)
                        text = ""
                        save()

                    } label: {
                        Image(systemName: "plus")
                            .font(.system(size: 34, weight: .semibold, design: .rounded))
                    }

                    .fixedSize()
                    .foregroundColor(.accentColor)
                }
                Spacer()
                if notes.count >= 1 {
                    List {
                        ForEach(0 ..< notes.count, id: \.self) { note in
                            NavigationLink(destination:DetailView(note: notes[note], count: notes.count, index: note)) {
                                HStack {
                                    Capsule()
                                        .frame(width: 4)
                                        .foregroundColor(.accentColor)
                                    Text(notes[note].text)
                                        .lineLimit(lineCount)
                                        .padding(.leading, 5)
                                }
                            }
                        }.onDelete { IndexSet in
                            delete(offsets: IndexSet)
                        }
                    }
                } else {
                    Spacer()
                    Image(systemName: "note.text")
                        .resizable()
                        .scaledToFit()
                        .padding(25)
                        .opacity(0.25)
                        .foregroundColor(.gray)
                    Spacer()
                }
            }
            .navigationTitle("Notes")
            .onAppear {
                load()
        }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

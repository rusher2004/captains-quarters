//
//  ContentView.swift
//  Captain's Quarters
//
//  Created by Robert Usher on 7/8/24.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var characters: [Character]

    var body: some View {
        if characters.isEmpty {
            Button {
                Task {
                    print("logging in")
                }
            } label: {
                Image("eve-sso-login-white-large")
            }
        } else {
            NavigationSplitView {
                List {
                    ForEach(characters) { character in
                        NavigationLink {
                            HStack {
                                AsyncImage(
                                    url: URL(
                                        string:
                                            "https://images.evetech.net/characters/\(character.id)/portrait?tenant=tranquility&size=512"
                                    )
                                ) { image in
                                    image.resizable()
                                } placeholder: {
                                    ProgressView()
                                }
                                .frame(width: 50, height: 50)

                                Text(character.name)
                            }
                        } label: {
                            AsyncImage(
                                url: URL(
                                    string:
                                        "https://images.evetech.net/characters/\(character.id)/portrait?tenant=tranquility&size=512"
                                )
                            ) { image in
                                image.resizable()

                            } placeholder: {
                                ProgressView()
                            }
                            .frame(width: 50, height: 50)
                            .clipShape(.circle)
                            Text(character.name)
                            //                        Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
                        }
                    }
                    .onDelete(perform: deleteCharacters)
                }
                #if os(macOS)
                    .navigationSplitViewColumnWidth(min: 180, ideal: 200)
                #endif
                .toolbar {
                    #if os(iOS)
                        ToolbarItem(placement: .navigationBarTrailing) {
                            EditButton()
                        }
                    #endif
                    ToolbarItem {
                        Button(action: addCharacter) {
                            Label("Add Item", systemImage: "plus")
                        }
                    }
                }
            } detail: {
                Text("Select an item")
            }
        }
    }

    private func addCharacter() {
        withAnimation {
            //            let newItem = Item(timestamp: Date())
            let newChar = Character(
                bloodlineID: 1, descriptiont: "", gender: "female",
                id: 1_521_661_259, name: "Fungus Amongus", raceID: 1,
                securityStatus: -1.495805459)
            modelContext.insert(newChar)
            //            modelContext.insert(c)
        }
    }

    private func deleteCharacters(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(characters[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Character.self, inMemory: true)
}

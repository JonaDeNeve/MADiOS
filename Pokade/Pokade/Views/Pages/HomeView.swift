//
//  ContentView.swift
//  Pokade
//
//  Created by Jona De Neve on 21/12/2022.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject private var store: SquirdleStore
    @State private var editMode: EditMode = .inactive
    @State private var isEditing = false
    @State private var gameToEdit: SquirdleViewModel?
    @State private var games: [SquirdleViewModel] = []
    
    var body: some View {
        NavigationView {
            List {
                ForEach(games) { game in
                    if editMode == .active {
                        rowContent(for: game)
                            .onTapGesture {
                                gameToEdit = game
                            }
                    } else {
                        NavigationLink {
                            SquirdleView(game)
                        } label: {
                            rowContent(for: game)
                        }
                    }
                }
                .onMove { indexSet, offset in
                    games.move(fromOffsets: indexSet, toOffset: offset)
                }
                .onDelete { indexSet in
                    games.remove(atOffsets: indexSet)
                }
            }
            .navigationTitle("Squirdle")
            .listStyle(.grouped)
            .toolbar {
                ToolbarItem {
                    EditButton()
                }
            }
            .compactableToolbar {
                AnimatedActionButton(title: "New game", systemImage: "plus") {
                    newGame()
                }
                AnimatedActionButton(title: "How to play", systemImage: "info.circle") {
                    
                }
            }
            .environment(\.editMode, $editMode)
        }
        .popover(item: $gameToEdit) { game in
            let index = games.firstIndex { $0.id == game.id }!
            NewGameForm(squirdle: $games[index])
        }
    }
    
    init() {
        self.gameToEdit = games.first
    }
    
    private func rowContent(for squirdle: SquirdleViewModel) -> some View {
        VStack(alignment: .leading) {
            Text("Game: \(squirdle.name != "" ? squirdle.name : "\(squirdle.id)")")
            Text("Guesses: \(squirdle.guesses.count)")
        }
    }
    
    private func newGame() {
        let squirdle = SquirdleViewModel()
        games.append(squirdle)
        gameToEdit = squirdle
        isEditing = true
    }
}

// MARK: Preview

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

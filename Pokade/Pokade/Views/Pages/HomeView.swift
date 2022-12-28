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
    @State private var games: [SquirdleViewModel] = [SquirdleViewModel(),SquirdleViewModel()]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(games) { game in
                    if editMode == .active {
                        rowContent(for: game)
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
                ToolbarItem() {
                    Button(action: newGame) {
                        Image(systemName: "plus")
                    }
                }
                ToolbarItem {
                    EditButton()
                }
            }
            .environment(\.editMode, $editMode)
        }
    }
    
    private func rowContent(for squirdle: SquirdleViewModel) -> some View {
        VStack(alignment: .leading) {
            Text("Game: \(squirdle.id)")
            Text("Guesses: \(squirdle.guesses.count)")
        }
    }
    
    private func newGame() {
        games.append(SquirdleViewModel())
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

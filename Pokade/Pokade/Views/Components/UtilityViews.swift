//
//  UtilityViews.swift
//  Pokade
//
//  Created by Jona De Neve on 26/12/2022.
//

import SwiftUI

// MARK: AnimatedActionButton
//Copied from L16 EmojiArt

struct AnimatedActionButton: View {
    var title: String? = nil
    var systemImage: String? = nil
    let action: () -> Void
    
    var body: some View {
        Button {
            withAnimation {
                action()
            }
        } label: {
            if title != nil && systemImage != nil {
                Label(title!, systemImage: systemImage!)
            } else if title != nil {
                Text(title!)
            } else if systemImage != nil {
                Image(systemName: systemImage!)
            }
        }
    }
}

// MARK: View
//Copied from L16 EmojiArt

extension View {
    func compactableToolbar<Content>(@ViewBuilder content: () -> Content) -> some View where Content: View {
        self.toolbar {
            content().modifier(CompactableIntoContextMenu())
        }
    }
}

// MARK: CompactableIntoContextMenu
//Copied from L16 EmojiArt


struct CompactableIntoContextMenu: ViewModifier {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    var compact: Bool { horizontalSizeClass == .compact }
    
    func body(content: Content) -> some View {
        if compact {
            Button {
                
            } label: {
                Image(systemName: "ellipsis.circle")
            }
            .contextMenu {
                content
            }
        } else {
            content
        }
    }
}

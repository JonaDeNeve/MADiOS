//
//  GameInfo.swift
//  Pokade
//
//  Created by Jona De Neve on 29/12/2022.
//

import SwiftUI

struct GameInfo: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(spacing: 15) {
            if UIDevice.current.userInterfaceIdiom != .pad {
                Button("Close") {
                    dismiss()
                }
            }
            Spacer()
            Text("The goal of Squirdle is to find the hidden pokemon. By guessing other pokemon you can aquirre information.")
            HStack(spacing: 20) {
                Image(systemName: "checkmark")
                    .background(RoundedRectangle(cornerRadius: 10).fill(.green)
                        .padding(-5))
                Text("The values of both pokemon match.")
            }
            HStack(spacing: 20) {
                Image(systemName: "xmark")
                    .background(RoundedRectangle(cornerRadius: 10).fill(.red)
                        .padding(-5))
                Text("The guessed type is wrong.")
            }
            HStack(spacing: 20) {
                Image(systemName: "arrow.left.arrow.right")
                    .background(RoundedRectangle(cornerRadius: 10).fill(.orange)
                        .padding(-5))
                Text("The guessed type is in the wrong position.")
            }
            HStack(spacing: 20) {
                Image(systemName: "triangle.fill")
                    .background(RoundedRectangle(cornerRadius: 10).fill(.blue)
                        .padding(-5))
                Text("The target value is higher.")
            }
            HStack(spacing: 20) {
                Image(systemName: "triangle.fill")
                    .rotationEffect(.radians(.pi))
                    .background(RoundedRectangle(cornerRadius: 10).fill(.blue)
                        .padding(-5))
                Text("The target value is lower.")
            }
            Spacer()
        }
        .padding(.horizontal)
        .font(.title2)
    }
}

struct GameInfo_Previews: PreviewProvider {
    static var previews: some View {
        GameInfo()
    }
}

//
//  GameInfo.swift
//  Pokade
//
//  Created by Jona De Neve on 29/12/2022.
//

import SwiftUI

struct GameInfo: View {
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "checkmark")
                    .background(Rectangle().fill(.green))
                Text("means the values of both pokemon match.")
            }
            HStack {
                Image(systemName: "xmark")
                    .background(Rectangle().fill(.red))
                Text("means the guessed type is wrong.")
            }
            HStack {
                Image(systemName: "arrow.left.arrow.right")
                    .background(Rectangle().fill(.green))
                Text("means the guessed type is in the wrong position.")
            }
            HStack {
                Image(systemName: "triangle.fill")
                    .background(Rectangle().fill(.blue))
                Text("means the guessed value is lower.")
            }
            HStack {
                Image(systemName: "triangle.fill")
                    .rotationEffect(.radians(.pi))
                    .background(Rectangle().fill(.blue))
                Text("means the guessed value is higher.")
            }
        }
    }
}

struct GameInfo_Previews: PreviewProvider {
    static var previews: some View {
        GameInfo()
    }
}

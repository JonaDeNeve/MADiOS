//
//  SquirdleView.swift
//  Pokade
//
//  Created by Jona De Neve on 22/12/2022.
//

import SwiftUI

struct SquirdleView: View {
    var body: some View {
        VStack{
            VStack {
                HStack {
                    Text("Gen")
                    Text("Type 1")
                    Text("Type 2")
                    Text("Height")
                    Text("Weight")
                }
                .font(.title2)
                row
                row
                row
            }
            Spacer()
            HStack {
                
            }
        }
        .padding(.horizontal)
    }
    
    var row: some View {
        HStack {
            Pokeball(status: .correct)
            Pokeball(status: .incorrect)
            Pokeball(status: .higher)
            Pokeball(status: .lower)
            Pokeball(status: .wrongPosition)
        }
    }
}

struct SquirdleView_Previews: PreviewProvider {
    static var previews: some View {
        SquirdleView()
    }
}

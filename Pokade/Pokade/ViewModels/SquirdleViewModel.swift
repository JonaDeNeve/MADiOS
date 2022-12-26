//
//  SquirdleViewModel.swift
//  Pokade
//
//  Created by Jona De Neve on 25/12/2022.
//

import Foundation

class SquirdleViewModel: ObservableObject {
    
    @Published private(set) var squirdle: Squirdle
    
    init() {
        squirdle = Squirdle()
    }
}

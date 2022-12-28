//
//  SquirdleStore.swift
//  Pokade
//
//  Created by Jona De Neve on 26/12/2022.
//

import SwiftUI

class SquirdleStore: ObservableObject {
    
    @AppStorage("settings") private var _settings = Data()
    
}

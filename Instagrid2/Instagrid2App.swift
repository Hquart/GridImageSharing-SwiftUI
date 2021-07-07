//
//  Instagrid2App.swift
//  Instagrid2
//
//  Created by Naji Achkar on 27/12/2020.
//

import Combine
import SwiftUI

@main
struct Instagrid2App: App {
    
    @StateObject var layout = Layout()
    @StateObject var device = OrientationInfo()
    
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(layout)
                .environmentObject(device)
        }
    }
}






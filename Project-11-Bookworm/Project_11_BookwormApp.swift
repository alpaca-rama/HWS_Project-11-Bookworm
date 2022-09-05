//
//  Project_11_BookwormApp.swift
//  Project-11-Bookworm
//
//  Created by Luca Capriati on 2022/09/05.
//

import SwiftUI

@main
struct Project_11_BookwormApp: App {
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}

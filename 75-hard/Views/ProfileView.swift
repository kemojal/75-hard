//
//  ProfileView.swift
//  75-hard
//
//  Created by Kemo Jallow on 2025/1/4.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("User Info")) {
                    Text("Name: John Doe")
                    Text("Start Date: January 1, 2024")
                    Text("Current Day: 35")
                }
                
                Section(header: Text("Settings")) {
                    Toggle("Notifications", isOn: .constant(true))
                    Toggle("Dark Mode", isOn: .constant(false))
                }
            }
            .navigationTitle("Profile")
        }
    }
}

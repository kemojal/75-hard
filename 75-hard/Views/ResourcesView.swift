//
//  ResourcesView.swift
//  75-hard
//
//  Created by Kemo Jallow on 2025/1/4.
//

import SwiftUI

struct ResourcesView: View {
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Workout Ideas")) {
                    Text("Beginner Workouts")
                    Text("Outdoor Activities")
                    Text("Home Workouts")
                }
                
                Section(header: Text("Reading List")) {
                    Text("Recommended Books")
                    Text("Reading Tips")
                }
                
                Section(header: Text("Diet Resources")) {
                    Text("Meal Plans")
                    Text("Nutrition Guidelines")
                }
            }
            .navigationTitle("Resources")
        }
    }
}

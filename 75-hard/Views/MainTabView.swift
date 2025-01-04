//
//  MainTabView.swift
//  75-hard
//
//  Created by Kemo Jallow on 2025/1/4.
//
import SwiftUI
struct MainTabView: View {
    var body: some View {
        TabView {
            TodayView()
                .tabItem {
                    Label("Today", systemImage: "checkmark.circle")
                }
            
            ProgressView()
                .tabItem {
                    Label("Progress", systemImage: "chart.bar")
                }
            
            ResourcesView()
                .tabItem {
                    Label("Resources", systemImage: "book")
                }
            
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
        }
    }
}

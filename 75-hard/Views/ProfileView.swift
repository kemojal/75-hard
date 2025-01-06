//
//  ProfileView.swift
//  75-hard
//
//  Created by Kemo Jallow on 2025/1/4.
//
import SwiftUI

struct ProfileView: View {
    @State private var notificationsEnabled: Bool = true
    @State private var darkModeEnabled: Bool = false
    @State private var profilePicture: UIImage? = nil // Placeholder

    var body: some View {
        NavigationView {
            List {
                // User Info Section
                Section(header: Text("User Info").font(.headline).foregroundColor(.primary).padding(.vertical, 10)) {
                    HStack {
                        Button(action: {
                            // Action to change profile picture
                        }) {
                            if let image = profilePicture {
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 70, height: 70)
                                    .cornerRadius(35)
                                    .shadow(radius: 5)
                            } else {
                                Image(systemName: "person.fill")
                                    .font(.system(size: 40))
                                    .foregroundColor(.white)
                                    .frame(width: 70, height: 70)
                                    .background(Color.gray.opacity(0.5))
                                    .cornerRadius(35)
                                    .shadow(radius: 5)
                            }
                        }
                        VStack(alignment: .leading) {
                            Text("Name: John Doe")
                                .font(.title2)
                                .fontWeight(.bold)
                            Text("Start Date: January 1, 2024")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                        }
                    }
                    .padding(.horizontal, 10)

                    HStack {
                        Image(systemName: "calendar")
                            .foregroundColor(.blue)
                            .font(.system(size: 20))
                        Text("Current Day: 35")
                            .font(.subheadline)
                    }
                    .padding(.horizontal, 10)
                }

                // Achievements Section
                Section(header: Text("Achievements").font(.headline).foregroundColor(.primary).padding(.vertical, 10)) {
                    HStack {
                        Image(systemName: "trophy.fill")
                            .foregroundColor(.yellow)
                            .font(.system(size: 20))
                        Text("Completed 30 Days")
                            .font(.subheadline)
                    }
                    .padding(.horizontal, 10)
                }

                // Settings Section
                Section(header: Text("Settings").font(.headline).foregroundColor(.primary).padding(.vertical, 10)) {
                    Toggle("Notifications", isOn: $notificationsEnabled)
                        .toggleStyle(SwitchToggleStyle(tint: .blue))
                    Toggle("Dark Mode", isOn: $darkModeEnabled)
                        .toggleStyle(SwitchToggleStyle(tint: .blue))
                }
                .listRowBackground(Color(.systemBackground))
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        // Edit profile action
                    }) {
                        Image(systemName: "pencil")
                            .foregroundColor(.blue)
                    }
                }
            }
        }
    }
}

#Preview {
    ProfileView()
}

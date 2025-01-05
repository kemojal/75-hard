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
                Section(header: Text("User Info").font(.headline)) {
                    HStack {
                        if let image = profilePicture {
                            Image(uiImage: image)
                                .resizable()
                                .frame(width: 50, height: 50)
                                .cornerRadius(25)
                        } else {
                            Image(systemName: "person.fill")
                                .font(.largeTitle)
                                .foregroundColor(.primaryColor)
                                .frame(width: 50, height: 50)
                                .background(Color.secondaryColor)
                                .cornerRadius(25)
                        }
                        VStack(alignment: .leading) {
                            Text("Name: John Doe")
                                .font(.subheadline)
                            Text("Start Date: January 1, 2024")
                                .font(.subheadline)
                        }
                    }
                    .padding(.horizontal, 10)

                    HStack {
                        Image(systemName: "calendar")
                            .foregroundColor(.primaryColor)
                            .font(.system(size: 20))
                        Text("Current Day: 35")
                            .font(.subheadline)
                    }
                    .padding(.horizontal, 10)
                }

                // Achievements Section
                Section(header: Text("Achievements").font(.headline)) {
                    HStack {
                        Image(systemName: "trophy.fill")
                            .foregroundColor(.primaryColor)
                            .font(.system(size: 20))
                        Text("Completed 30 Days")
                            .font(.subheadline)
                    }
                    .padding(.horizontal, 10)
                }

                // Settings Section
                Section(header: Text("Settings").font(.headline)) {
                    Toggle("Notifications", isOn: $notificationsEnabled)
                        .toggleStyle(SwitchToggleStyle(tint: .primaryColor))
                    Toggle("Dark Mode", isOn: $darkModeEnabled)
                        .toggleStyle(SwitchToggleStyle(tint: .primaryColor))
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
                            .foregroundColor(.primaryColor)
                    }
                }
            }
        }
    }
}



#Preview {
    ProfileView()
}

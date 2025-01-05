//
//  ResourcesView.swift
//  75-hard
//
//  Created by Kemo Jallow on 2025/1/4.
//

import SwiftUI

// MARK: - Resource Item Model
struct ResourceItem: Identifiable, Equatable {
    let id = UUID() // Unique identifier
    let title: String
    let detailView: AnyView

    static func == (lhs: ResourceItem, rhs: ResourceItem) -> Bool {
        lhs.id == rhs.id
    }
}


// MARK: - ResourcesView
struct ResourcesView: View {
    let resources = [
        (title: "Workout Ideas", icon: "dumbbell.fill", items: [
            ResourceItem(title: "Beginner Workouts", detailView: AnyView(BeginnerWorkoutsView())),
            ResourceItem(title: "Outdoor Activities", detailView: AnyView(OutdoorActivitiesView())),
            ResourceItem(title: "Home Workouts", detailView: AnyView(HomeWorkoutsView()))
        ]),
        (title: "Reading List", icon: "book.fill", items: [
            ResourceItem(title: "Recommended Books", detailView: AnyView(RecommendedBooksView())),
            ResourceItem(title: "Reading Tips", detailView: AnyView(ReadingTipsView()))
        ]),
        (title: "Diet Resources", icon: "leaf.fill", items: [
            ResourceItem(title: "Meal Plans", detailView: AnyView(MealPlansView())),
            ResourceItem(title: "Nutrition Guidelines", detailView: AnyView(NutritionGuidelinesView()))
        ])
    ]

    @State private var selectedItem: ResourceItem? = nil

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(resources, id: \.title) { resource in
                        ResourceCard(title: resource.title, icon: resource.icon, items: resource.items, selectedItem: $selectedItem)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 10)
            }
            .navigationTitle("Resources")
            .background(Color(.systemGroupedBackground).edgesIgnoringSafeArea(.all))
        }
    }
}

// MARK: - Resource Card Component
struct ResourceCard: View {
    let title: String
    let icon: String
    let items: [ResourceItem]
    @Binding var selectedItem: ResourceItem?

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Header with Icon and Title
            HStack {
                Image(systemName: icon)
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(width: 40, height: 40)
                    .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .topLeading, endPoint: .bottomTrailing))
                    .cornerRadius(10)
                    .shadow(color: Color.blue.opacity(0.3), radius: 5, x: 0, y: 3)

                Text(title)
                    .font(.system(size: 20, weight: .semibold, design: .rounded))
                    .foregroundColor(.primary)
            }
            .padding(.bottom, 10)

            // Items List
            ForEach(items) { item in
                NavigationLink(destination: item.detailView) {
                    HStack {
                        Text(item.title)
                            .font(.system(size: 16, weight: .medium, design: .rounded))
                            .foregroundColor(.primary)
                            .padding(.vertical, 12)
                            .padding(.horizontal, 16)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color(.secondarySystemBackground))
                            .cornerRadius(10)
                            .shadow(color: Color.black.opacity(0.1), radius: 3, x: 0, y: 2)

                        Image(systemName: "chevron.right")
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.secondary)
                    }
                }
                .padding(.vertical, 4)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
        .animation(.easeInOut(duration: 0.3), value: items)
    }
}

#Preview {
    ResourcesView()
}

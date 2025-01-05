//
//  MealPlansListView.swift
//  75-hard
//
//  Created by Kemo Jallow on 2025/1/5.
//
import SwiftUI
import WebKit

struct MealPlansListView: View {
    @State private var meals: [Meal] = [] // Fetch meals from an API
    @State private var searchText: String = ""
    @State private var selectedMeal: Meal? = nil
    @State private var isRefreshing: Bool = false

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Search Bar
                SearchBar2(text: $searchText, placeholder: "Search meals...")
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(Color(.systemBackground))
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)

                // Meal List
                List(filteredMeals, id: \.id) { meal in
                    MealRow(meal: meal)
                        .onTapGesture {
                            selectedMeal = meal // Set the selected meal
                        }
                        .listRowInsets(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                        .listRowBackground(Color(.systemBackground))
                        .listRowSeparator(.hidden)
                }
                .listStyle(PlainListStyle())
                .refreshable {
                    await refreshMeals()
                }
                .overlay(
                    Group {
                        if meals.isEmpty && !isRefreshing {
                            Text("No meals found.")
                                .font(.system(size: 18, weight: .medium, design: .rounded))
                                .foregroundColor(.secondary)
                        }
                    }
                )
                .navigationTitle("Meal Plans")
                .background(Color(.systemGroupedBackground).edgesIgnoringSafeArea(.all))
                .sheet(item: $selectedMeal) { meal in
                    MealDetailView(meal: meal)
                }
            }
        }
        .onAppear {
            fetchMeals()
        }
    }

    // Filter meals based on search text
    var filteredMeals: [Meal] {
        if searchText.isEmpty {
            return meals
        } else {
            return meals.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }

    // Fetch sample meals
    func fetchMeals() {
        let sampleMeals = [
            Meal(id: "1", name: "Grilled Chicken Salad", description: "High-protein, low-carb meal.", image: "grilled_chicken_salad", ingredients: ["Chicken breast", "Lettuce", "Tomatoes", "Cucumbers", "Olive oil"], instructions: "1. Grill the chicken breast. 2. Chop the vegetables. 3. Toss everything together with olive oil."),
            Meal(id: "2", name: "Vegetable Stir Fry", description: "Healthy and quick to prepare.", image: "vegetable_stir_fry", ingredients: ["Broccoli", "Carrots", "Bell peppers", "Soy sauce", "Garlic"], instructions: "1. Chop the vegetables. 2. Stir-fry in a pan with soy sauce and garlic."),
            Meal(id: "3", name: "Quinoa Bowl", description: "Nutrient-packed and delicious.", image: "quinoa_bowl", ingredients: ["Quinoa", "Avocado", "Black beans", "Corn", "Lime"], instructions: "1. Cook the quinoa. 2. Add black beans, corn, and avocado. 3. Squeeze lime juice on top."),
            Meal(id: "4", name: "Salmon with Asparagus", description: "Rich in omega-3 and vitamins.", image: "salmon_asparagus", ingredients: ["Salmon fillet", "Asparagus", "Lemon", "Olive oil", "Garlic"], instructions: "1. Season the salmon. 2. Roast with asparagus and garlic. 3. Squeeze lemon juice before serving.")
        ]
        meals = sampleMeals
    }

    // Refresh meals
    func refreshMeals() async {
        isRefreshing = true
        // Simulate a network request delay using DispatchQueue
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.5) {
            DispatchQueue.main.async {
                fetchMeals()
                isRefreshing = false
            }
        }
    }
}

// MARK: - Meal Row

struct MealRow: View {
    let meal: Meal

    var body: some View {
        HStack(spacing: 12) {
            // Meal Image
            Image(meal.image)
                .resizable()
                .scaledToFill()
                .frame(width: 80, height: 80)
                .cornerRadius(12)
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 3)

            // Meal Details
            VStack(alignment: .leading, spacing: 4) {
                Text(meal.name)
                    .font(.system(size: 18, weight: .semibold, design: .rounded))
                    .foregroundColor(.primary)
                Text(meal.description)
                    .font(.system(size: 14, weight: .medium, design: .rounded))
                    .foregroundColor(.secondary)
                    .lineLimit(2)
            }

            Spacer()

            // Chevron Icon
            Image(systemName: "chevron.right")
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 8)
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 3)
    }
}

// MARK: - Meal Detail View

struct MealDetailView: View {
    let meal: Meal

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Meal Image
                Image(meal.image)
                    .resizable()
                    .scaledToFill()
                    .frame(height: 250)
                    .clipped()
                    .cornerRadius(12)
                    .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)

                // Meal Name
                Text(meal.name)
                    .font(.system(size: 28, weight: .bold, design: .rounded))
                    .foregroundColor(.primary)

                // Meal Description
                Text(meal.description)
                    .font(.system(size: 16, weight: .medium, design: .rounded))
                    .foregroundColor(.secondary)
                    .lineSpacing(5)

                // Ingredients
                VStack(alignment: .leading, spacing: 10) {
                    Text("Ingredients")
                        .font(.system(size: 20, weight: .semibold, design: .rounded))
                        .foregroundColor(.primary)

                    ForEach(meal.ingredients, id: \.self) { ingredient in
                        HStack(alignment: .top) {
                            Image(systemName: "circle.fill")
                                .font(.system(size: 8))
                                .foregroundColor(.blue)
                                .padding(.top, 8)
                            Text(ingredient)
                                .font(.system(size: 16, weight: .medium, design: .rounded))
                                .foregroundColor(.primary)
                                .lineSpacing(5)
                        }
                    }
                }

                // Instructions
                VStack(alignment: .leading, spacing: 10) {
                    Text("Instructions")
                        .font(.system(size: 20, weight: .semibold, design: .rounded))
                        .foregroundColor(.primary)

                    Text(meal.instructions)
                        .font(.system(size: 16, weight: .medium, design: .rounded))
                        .foregroundColor(.secondary)
                        .lineSpacing(5)
                }

                Spacer()
            }
            .padding()
        }
        .navigationTitle(meal.name)
        .background(Color(.systemGroupedBackground).edgesIgnoringSafeArea(.all))
    }
}

// MARK: - Meal Model

struct Meal: Identifiable {
    let id: String
    let name: String
    let description: String
    let image: String
    let ingredients: [String]
    let instructions: String
}

// MARK: - Search Bar

struct SearchBar2: View {
    @Binding var text: String
    var placeholder: String

    var body: some View {
        HStack {
            TextField(placeholder, text: $text)
                .padding(10)
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding(.horizontal, 10)

            if !text.isEmpty {
                Button(action: {
                    text = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
                .padding(.trailing, 10)
            }
        }
        .padding(.vertical, 8)
        .background(Color(.systemBackground))
    }
}


// MARK: - Previews

#Preview {
   
      
            MealPlansListView()
        
    
}

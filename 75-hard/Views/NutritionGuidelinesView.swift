//
//  NutritionGuidelinesView.swift
//  75-hard
//
//  Created by Kemo Jallow on 2025/1/5.
//
import SwiftUI

import SwiftUI

struct NutritionGuidelinesView: View {
    var body: some View {
        ResourceDetailView(
            title: "Nutrition Guidelines",
            icon: "leaf.fill",
            description: "Understand the basics of nutrition to make informed dietary choices.",
            tips: [
                "Focus on whole, unprocessed foods.",
                "Stay hydrated by drinking plenty of water.",
                "Limit added sugars and unhealthy fats."
            ],
            actionButtonTitle: "Learn More",
            destination: AnyView(NutritionGuideView()) // Pass a valid View
        )
    }
}

// MARK: - Nutrition Guide View

struct NutritionGuideView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Nutrition Guide")
                    .font(.system(size: 28, weight: .bold, design: .rounded))
                    .foregroundColor(.primary)

                Text("Learn about the basics of nutrition and how to make healthy dietary choices.")
                    .font(.system(size: 16, weight: .medium, design: .rounded))
                    .foregroundColor(.secondary)
                    .lineSpacing(5)

                VStack(alignment: .leading, spacing: 10) {
                    Text("Key Principles")
                        .font(.system(size: 20, weight: .semibold, design: .rounded))
                        .foregroundColor(.primary)

                    ForEach([
                        "Eat a variety of foods.",
                        "Balance your meals with proteins, carbs, and fats.",
                        "Avoid processed foods and added sugars."
                    ], id: \.self) { tip in
                        HStack(alignment: .top) {
                            Image(systemName: "circle.fill")
                                .font(.system(size: 8))
                                .foregroundColor(.blue)
                                .padding(.top, 8)
                            Text(tip)
                                .font(.system(size: 16, weight: .medium, design: .rounded))
                                .foregroundColor(.primary)
                                .lineSpacing(5)
                        }
                    }
                }

                Button(action: {
                    // Open an external website or detailed guide
                    if let url = URL(string: "https://www.nutrition.gov") {
                        UIApplication.shared.open(url)
                    }
                }) {
                    Text("Visit Nutrition.gov")
                        .font(.system(size: 18, weight: .semibold, design: .rounded))
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .topLeading, endPoint: .bottomTrailing))
                        .cornerRadius(10)
                        .shadow(color: Color.blue.opacity(0.3), radius: 5, x: 0, y: 3)
                }
                .padding(.top, 20)
            }
            .padding()
        }
        .navigationTitle("Nutrition Guide")
        .background(Color(.systemGroupedBackground).edgesIgnoringSafeArea(.all))
    }
}

// MARK: - Previews

//struct NutritionGuidelinesView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationView {
//            NutritionGuidelinesView()
//        }
//    }
//}
#Preview {
    NutritionGuidelinesView() }

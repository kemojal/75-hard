//
//  BookListView.swift
//  75-hard
//
//  Created by Kemo Jallow on 2025/1/5.
//

import SwiftUI
import WebKit

struct BookListView: View {
    @State private var books: [Book] = [] // Fetch books from an API
    @State private var searchText: String = ""

    var body: some View {
        VStack {
            // Search Bar
            SearchBar(text: $searchText, placeholder: "Search books...")
                .padding(.horizontal)

            // Book List
            List(filteredBooks, id: \.id) { book in
                BookRow(book: book)
                    .onTapGesture {
                        // Open book details or external link
                        openBookDetails(book: book)
                    }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationTitle("Recommended Books")
        }
        .onAppear {
            // Fetch books from an API (e.g., Google Books API)
            fetchBooks()
        }
    }

    // Filter books based on search text
    var filteredBooks: [Book] {
        if searchText.isEmpty {
            return books
        } else {
            return books.filter { $0.title.localizedCaseInsensitiveContains(searchText) || $0.author.localizedCaseInsensitiveContains(searchText) }
        }
    }

    // Fetch sample books
    func fetchBooks() {
        let sampleBooks = [
            Book(id: "1", title: "Atomic Habits", author: "James Clear", coverImage: "atomic_habits", description: "A revolutionary guide to building good habits and breaking bad ones."),
            Book(id: "2", title: "The Power of Now", author: "Eckhart Tolle", coverImage: "power_of_now", description: "A spiritual guide to living in the present moment."),
            Book(id: "3", title: "Deep Work", author: "Cal Newport", coverImage: "deep_work", description: "Learn how to focus and achieve more in less time."),
            Book(id: "4", title: "The 7 Habits of Highly Effective People", author: "Stephen R. Covey", coverImage: "7_habits", description: "A powerful framework for personal and professional effectiveness.")
        ]
        books = sampleBooks
    }

    // Open book details or external link
    func openBookDetails(book: Book) {
        if let url = URL(string: "https://www.amazon.com/s?k=\(book.title.replacingOccurrences(of: " ", with: "+"))") {
            UIApplication.shared.open(url)
        }
    }
}
struct Book: Identifiable {
    let id: String
    let title: String
    let author: String
    let coverImage: String
    let description: String
}
#Preview {
    BookListView()
}

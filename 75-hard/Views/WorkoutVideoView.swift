//
//  WorkoutVideoView.swift
//  75-hard
//
//  Created by Kemo Jallow on 2025/1/5.
//

import SwiftUI
import WebKit // For embedding workout videos

// MARK: - Workout Actions

struct WorkoutVideoView: View {
    let videoID: String // YouTube video ID

    var body: some View {
        WebView(url: "https://www.youtube.com/embed/\(videoID)")
            .frame(height: 300)
            .cornerRadius(10)
            .padding()
            .navigationTitle("Workout Video")
    }
}

struct WebView: UIViewRepresentable {
    let url: String

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        if let url = URL(string: url) {
            webView.load(URLRequest(url: url))
        }
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {}
}
#Preview {
    WorkoutVideoView(videoID: "")
}
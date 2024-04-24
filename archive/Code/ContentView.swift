import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            // Tab 1
            if let url = Bundle.main.url(forResource: "index", withExtension: "html") {
                WebView(request: URLRequest(url: url), baseURL: url.deletingLastPathComponent())
                    .tabItem {
                        Image(systemName: "1.square.fill")
                        Text("Tab 1")
                    }
                    .tag(0)
            } else {
                Text("Failed to load the URL");
            }
            
            // Tab 2
            if let url = URL(string: "https://breakout-x.github.io/Breakout-X/newtab/iOS/") {
                WebView(request: URLRequest(url: url), baseURL: url.deletingLastPathComponent())
                    .tabItem {
                        Image(systemName: "2.square.fill")
                        Text("Tab 2")
                    }
                    .tag(1)
            } else {
                Text("Failed to load the URL");
            }
            
            // Tab 3
            if let url = URL(string: "https://breakout-x.github.io/Breakout-X/newtab/iOS/") {
                WebView(request: URLRequest(url: url), baseURL: url.deletingLastPathComponent())
                    .tabItem {
                        Image(systemName: "3.square.fill")
                        Text("New Tab")
                    }
                    .tag(2)
            } else {
                Text("Failed to load the URL");
            }
        }
    }
}


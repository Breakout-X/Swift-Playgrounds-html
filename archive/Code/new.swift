struct ContentView: View {
    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            // Tab 1
            WebView(request: URLRequest(url: Bundle.main.url(forResource: "index", withExtension: "html")!))
                .tabItem {
                    Image(systemName: "1.square.fill")
                    Text("Tab 1")
                }
                .tag(0)
            
            // Tab 2
            WebView(request: URLRequest(url: URL(string: "https://breakout-x.github.io/Breakout-X/")!))
                .tabItem {
                    Image(systemName: "2.square.fill")
                    Text("Tab 2")
                }
                .tag(1)
        }
    }
}

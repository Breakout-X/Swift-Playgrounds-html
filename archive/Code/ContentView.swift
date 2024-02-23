import SwiftUI

//this ContentView loads a local resource
struct ContentView: View {
    var body: some View {
        let url = Bundle.main.url(forResource: "index", withExtension: "html")!
        WebView(request: URLRequest(url: url), baseURL: url.deletingLastPathComponent())
    }
}

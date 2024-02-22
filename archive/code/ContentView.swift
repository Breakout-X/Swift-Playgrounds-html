import SwiftUI

//this ContentView loads a local resource
struct ContentView: View {
    var body: some View {
        WebView(request: URLRequest(url: Bundle.main.url(forResource: "index", withExtension: "html")!))
    }
}

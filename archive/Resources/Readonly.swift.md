ContentView.swift unused code
```Swift
import SwiftUI

// loads an online resource but fixed to online only
struct ContentView: View {
    var body: some View {
        WebView(request: URLRequest(url: URL(string: "https://breakout-X.github.io/web-breakout")!))
    }
}

//loads a changable url but can request some... odd urls
struct ContentView: View {
    @State private var urlString = "https://breakout-X.github.io/web-breakout"
    @State private var request: URLRequest = URLRequest(url: URL(string: "https://breakout-X.github.io/web-breakout")!)
    
    var body: some View {
        VStack {
            TextField("Enter URL", text: $urlString, onCommit: {
                self.loadURL()
            })
            WebView(request: $request)
        }
    }
    
    func loadURL() {
        if let url = URL(string: urlString) {
            request = URLRequest(url: url)
        }
    }
}
```
WebView.swift unused code
```Swift
import SwiftUI
import WebKit

//loads normal urls but not with scripts because of high security
struct WebView: UIViewRepresentable {
    let request: URLRequest
    
    func makeUIView(context: Context) -> WKWebView  {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.load(request)
    }
}

//loads changable urls
struct WebView: UIViewRepresentable {
    @Binding var request: URLRequest
    
    func makeUIView(context: Context) -> WKWebView  {
        return WKWebView()
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.load(request)
    }
}
```

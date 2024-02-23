import SwiftUI
import WebKit

//loads normal urls, but with scripts
struct WebView: UIViewRepresentable {
    let request: URLRequest
    let baseURL: URL?
    
    func makeUIView(context: Context) -> WKWebView  {
        let preferences = WKWebpagePreferences()
        preferences.allowsContentJavaScript = true
        
        let configuration = WKWebViewConfiguration()
        configuration.defaultWebpagePreferences = preferences
        
        // Add a script to set the base URL in your HTML file
        let source = "var meta = document.createElement('meta');" +
        "meta.name = 'base';" +
        "meta.content = '\(baseURL?.absoluteString ?? "")';" +
        "document.getElementsByTagName('head')[0].appendChild(meta);"
        let script = WKUserScript(source: source, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        configuration.userContentController.addUserScript(script)
        
        let webView = WKWebView(frame: .zero, configuration: configuration)
        webView.uiDelegate = context.coordinator
        return webView
        
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let baseURL = baseURL {
            uiView.loadFileURL(request.url!, allowingReadAccessTo: baseURL)
        } else {
            uiView.load(request)
        }
    }

    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    class Coordinator: NSObject, WKUIDelegate {
        var window: UIWindow? {
            return UIApplication.shared.connectedScenes
                .filter { $0.activationState == .foregroundActive }
                .map { $0 as? UIWindowScene }
                .compactMap { $0 }
                .first?.windows
                .filter { $0.isKeyWindow }.first
        }
        func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
            let alertController = UIAlertController(title: "", message: message, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in completionHandler() }))
            window?.rootViewController?.present(alertController, animated: true, completion: nil)
        }
        
        func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (String?) -> Void) {
            let alertController = UIAlertController(title: prompt, message: nil, preferredStyle: .alert)
            alertController.addTextField { textField in
                textField.text = defaultText
            }
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                completionHandler(alertController.textFields?.first?.text)
            }))
            UIApplication.shared.windows.first?.rootViewController?.present(alertController, animated: true, completion: nil)
        }
        
        func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
            let alertController = UIAlertController(title: "", message: message, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in completionHandler(true) }))
            alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { _ in completionHandler(false) }))
            UIApplication.shared.windows.first?.rootViewController?.present(alertController, animated: true, completion: nil)
        }
    }
}

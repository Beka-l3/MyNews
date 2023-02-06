//
//  WebPageController.swift
//  MyNews
//
//  Created by Bekzhan Talgat on 05.02.2023.
//

import UIKit
import WebKit

class WebPageController: UIViewController, Colors {
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.color = focusColor
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    private lazy var webView: WKWebView = {
        let view = WKWebView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let errorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .thin)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    var urlString: String?
        
    override func viewDidLoad() { super.viewDidLoad()
        view.backgroundColor = .white
        
        setupViews()
        loadAddress()
        
        webView.navigationDelegate = self
        errorLabel.isHidden = true
        activityIndicator.startAnimating()
    }
    
    override func viewWillAppear(_ animated: Bool) { super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        errorLabel.isHidden = true
        webView.loadHTMLString("", baseURL: nil)
    }
    
    func setupViews() {
        view.addSubview(webView)
        view.addSubview(errorLabel)
        view.addSubview(activityIndicator)
    
        NSLayoutConstraint.activate([
            webView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            webView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            webView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor),
            webView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor),
            
            activityIndicator.centerXAnchor.constraint(equalTo: webView.centerXAnchor, constant: 0),
            activityIndicator.centerYAnchor.constraint(equalTo: webView.centerYAnchor, constant: 0),
            activityIndicator.widthAnchor.constraint(equalToConstant: 50),
            activityIndicator.heightAnchor.constraint(equalToConstant: 50),
            
            errorLabel.topAnchor.constraint(equalTo: activityIndicator.bottomAnchor, constant: 0),
            errorLabel.centerXAnchor.constraint(equalTo: activityIndicator.centerXAnchor),
            errorLabel.widthAnchor.constraint(equalTo: webView.widthAnchor, multiplier: 0.6),
            errorLabel.heightAnchor.constraint(equalToConstant: 70),
        ])
    }
    
    func loadAddress() {
        guard let urlString = urlString, let url = URL(string: urlString) else {
            display(error: "No urlContentItem passed or url is missing")
            return
        }
        
        activityIndicator.startAnimating()
        errorLabel.isHidden = true
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    func display(error: String) {
        activityIndicator.stopAnimating()
        errorLabel.isHidden = false
        errorLabel.text = error
    }
}


extension WebPageController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if navigationAction.navigationType == .linkActivated  {
            if let url = navigationAction.request.url,
                let host = url.host, !host.hasPrefix("www.google.com"),
                UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
                decisionHandler(.cancel)
                return
            } else {
                decisionHandler(.allow)
                return
            }
        } else {
            decisionHandler(.allow)
            return
        }
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        display(error: error.localizedDescription)
    }
}

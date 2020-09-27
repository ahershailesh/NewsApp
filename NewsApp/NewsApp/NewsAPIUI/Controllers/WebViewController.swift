//
//  WebViewController.swift
//  NewsApp
//
//  Created by Shailesh Aher on 27/09/20.
//  Copyright © 2020 Shailesh Aher. All rights reserved.
//

import UIKit
import WebKit

protocol WebViewRepresentable {
    var urlRequest: URLRequest { get }
    var title: String? { get }
}

class WebViewModel: WebViewRepresentable {
    let urlRequest: URLRequest
    let title: String?
    
    init(request: URLRequest, title: String) {
        self.urlRequest = request
        self.title = title
    }
}

class WebViewController: UIViewController {

    private lazy var webView: WKWebView = WKWebView.construct()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutViews()
    }

    private func layoutViews() {
        view.addSubview(webView)
        NSLayoutConstraint.activate([
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    func update(viewModel: WebViewRepresentable) {
        webView.load(viewModel.urlRequest)
        navigationItem.title = viewModel.title
    }
}

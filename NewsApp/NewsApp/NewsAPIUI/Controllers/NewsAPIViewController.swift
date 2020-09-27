//
//  ViewController.swift
//  NewsApp
//
//  Created by Shailesh Aher on 22/09/20.
//  Copyright © 2020 Shailesh Aher. All rights reserved.
//

import UIKit

class NewsAPIViewController: UIViewController {
    
    private lazy var scrollingView = NewsScrollerView(viewModel: viewModel)
    private let viewModel: NewsCardtableViewRepresentable
    
    init(viewModel: NewsCardtableViewRepresentable) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollingView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollingView)
        scrollingView.setup()
        NSLayoutConstraint.activate([
           scrollingView.topAnchor.constraint(equalTo: view.topAnchor),
           scrollingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
           scrollingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
           scrollingView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        navigationItem.title = "Head lines"
    }
}


//
//  NewsAPICoordinator.swift
//  NewsApp
//
//  Created by Shailesh Aher on 23/09/20.
//  Copyright © 2020 Shailesh Aher. All rights reserved.
//

import UIKit

protocol NewsAPIRoutable {
    func showNews(urlString: String, source: String)
}

struct NewsAPICoordinatorListener {
    var openNews: ((_ urlString: String, _ title: String) -> Void)?
}

class NewsAPICoordinator: NewsAPIRoutable {
    private let navController: UINavigationController
    
    init(navController: UINavigationController) {
        self.navController = navController
    }
    
    func start() {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        let executer = NetworkRequestExecuter(decoder: decoder)
        let intercepter = NewsAPIInterceptor(executer: executer)
        
        let listener = NewsAPICoordinatorListener(openNews: { [weak self] (urlString, source)  in
            self?.showNews(urlString: urlString, source: source)
        })
        
        let viewModel =  NewsCardTableViewModel(intercepter: intercepter, listener: listener)
        let controller = NewsAPIViewController(viewModel: viewModel)
        navController.setViewControllers([controller], animated: true)
    }
    
    func showNews(urlString: String, source: String) {
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)
        let viewModel = WebViewModel(request: request, title: source)
        
        let controller = WebViewController()
        let navigationController = UINavigationController(rootViewController: controller)
        navController.present(navigationController, animated: true, completion: nil)
        controller.update(viewModel: viewModel)
    }
}

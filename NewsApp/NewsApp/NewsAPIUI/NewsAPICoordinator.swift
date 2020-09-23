//
//  NewsAPICoordinator.swift
//  NewsApp
//
//  Created by Shailesh Aher on 23/09/20.
//  Copyright © 2020 Shailesh Aher. All rights reserved.
//

import UIKit

class NewsAPICoordinator {

    private let navController: UINavigationController
    
    init(navController: UINavigationController) {
        self.navController = navController
    }
    
    func start() {
        let homeManager = NewsAPIHomeScreenManager()
        let viewModel = ScrollerViewModel(tracker: homeManager)
        homeManager.contentReciever = viewModel
        let controller = NewsAPIViewController(viewModel: viewModel)
        navController.setViewControllers([controller], animated: true)
    }
    
}

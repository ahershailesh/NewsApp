//
//  NewsAPIHomeScreenManager.swift
//  NewsApp
//
//  Created by Shailesh Aher on 23/09/20.
//  Copyright © 2020 Shailesh Aher. All rights reserved.
//

import UIKit

class NewsAPIHomeScreenManager: ScrollViewItemTrakeable {
    private let interceptor = NewsAPIInterceptor()
        
    weak var contentReciever: ScrollViewContentUpdater?
    
    init() {
//        endPoints.getEverything(query: nil, source: nil) { [weak self] (response) in
//            let viewModels = response.articles.map { _ in NewsViewModel() }
//            self?.contentReciever?.updateNews(news: viewModels)
//        }
    }
    
    func currentViewingIndex(_ index: Int) {
        
    }
}

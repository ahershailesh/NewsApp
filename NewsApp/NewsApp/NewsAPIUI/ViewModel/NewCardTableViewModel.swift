//
//  NewCardTableViewModel.swift
//  NewsApp
//
//  Created by Shailesh Aher on 26/09/20.
//  Copyright © 2020 Shailesh Aher. All rights reserved.
//

import Foundation

enum TableViewUpdateType {
    case refresh, insert(indexes: [Int]), delete(indexes: [Int]), update
}

protocol TableViewUpdatable: class {
    func update(update: TableViewUpdateType)
}

protocol NewsCardtableViewRepresentable {
    var viewModels: [NewsCardTableViewCellRepresentable] { get }
    var updatable: TableViewUpdatable? { get set }
    
    func fetchCards()
    
    func openNews(at index: Int)
}


class NewsCardTableViewModel: NewsCardtableViewRepresentable {
    var viewModels: [NewsCardTableViewCellRepresentable] = []
    
    weak var updatable: TableViewUpdatable?

    private let listener: NewsAPICoordinatorListener
    private let intercepter: NewsAPIIntercepteable
    
    init(intercepter: NewsAPIIntercepteable = NewsAPIInterceptor(), listener: NewsAPICoordinatorListener) {
        self.intercepter = intercepter
        self.listener = listener
    }
    
    func fetchCards() {
        let configuration = NewsAPIHeadlinesConfiguration(query: nil, country: .in, category: nil, sources: nil)
        intercepter.getHeadLines(configuration: configuration, success: { [weak self] (response) in
            guard let self = self else { return }
            self.viewModels = response.articles.map { NewsCardTableViewCellViewModel(article: $0, listener: self.listener) }
            self.updatable?.update(update: .refresh)
        }) { (_) in
            
        }
    }
    
    func openNews(at index: Int) {
        viewModels[index].openNews()
    }
}

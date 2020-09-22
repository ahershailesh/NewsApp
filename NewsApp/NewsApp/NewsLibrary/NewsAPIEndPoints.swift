//
//  NewsAPIEndPoints.swift
//  NewsApp
//
//  Created by Shailesh Aher on 22/09/20.
//  Copyright © 2020 Shailesh Aher. All rights reserved.
//

import Foundation

struct NewsAPIResponse: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}

// MARK: - Article
struct Article: Codable {
    let source: Source
    let author: String?
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
}

// MARK: - Source
struct Source: Codable {
    let id: String?
    let name: String
}

class NewsAPIEndPoints {
    
    private let requestProvider: RequestProvider
    private let executer: NetworkRequestExecuter
    
    init(requestProvider: RequestProvider = RequestBuilder(serverURL: "https://newsapi.org/v2"),
         executer: NetworkRequestExecuter = NetworkService()) {
        self.requestProvider = requestProvider
        self.executer = executer
    }
    
    func getHeadLines(query: String?, source: String?, category: Category = .general) {
        let data = NewsAPIData(endPoint: .topHeadLines, query: query, country: nil, category: category, source: source)
        guard let request = requestProvider.request(with: data) else {
            return
        }
        executer.execute(request: request) { (item: NewsAPIResponse?, error) in
            
        }
    }
    
    func getEverything(query: String?, source: String?) {
        let defaultSource = source ?? (query == nil ? "google-news-in" : nil)
        let data = NewsAPIData(endPoint: .everything, query: query, country: nil, category: nil, source: defaultSource)
        guard let request = requestProvider.request(with: data) else {
            return
        }
        executer.execute(request: request) { (item: NewsAPIResponse?, error) in
            
        }
    }
}

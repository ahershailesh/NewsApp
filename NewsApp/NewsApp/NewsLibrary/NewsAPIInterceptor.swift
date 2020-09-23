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

class NewsAPIInterceptor {
    
    private let requestProvider: NetworkRequestConfigurator
    private let executer: NetworkRequestExecutable
    
    init(requestProvider: NetworkRequestConfigurator = NetworkRequestConstructor(serverURL: "https://newsapi.org/v2"),
         executer: NetworkRequestExecutable = NetworkRequestExecuter()) {
        self.requestProvider = requestProvider
        self.executer = executer
    }
    
    func getHeadLines(configuration: NewsAPIHeadlinesConfiguration, success: @escaping (NewsAPIResponse) -> Void, failure: @escaping (Error?) -> Void) {
        guard let request = requestProvider.request(with: NewAPIKeyIntegrater(endpoint: .topHeadLines(configuration: configuration))) else {
            failure(nil)
            return
        }
        executer.execute(request: request) { (item: NewsAPIResponse?, error) in
            if let item = item {
                success(item)
            } else {
                failure(error)
            }
        }
    }
    
    func getEverything(configuration: NewsAPIEverythingConfiguration, success: @escaping (NewsAPIResponse) -> Void, failure: @escaping (Error?) -> Void ) {
        
        guard let request = requestProvider.request(with: NewAPIKeyIntegrater(endpoint: .everything(configuration: configuration))) else {
            failure(nil)
            return
        }
        executer.execute(request: request) { (item: NewsAPIResponse?, error) in
            if let item = item {
                success(item)
            } else {
                failure(error)
            }
        }
    }
}

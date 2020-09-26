//
//  NewsAPIInterceptor.swift
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
    let publishedAt: Date?
    let content: String?
}

// MARK: - Source
struct Source: Codable {
    let id: String?
    let name: String
}

protocol NewsAPIIntercepteable {
    func getHeadLines(configuration: NewsAPIHeadlinesConfiguration, success: @escaping (NewsAPIResponse) -> Void, failure: @escaping (Error?) -> Void)
    func getEverything(configuration: NewsAPIEverythingConfiguration, success: @escaping (NewsAPIResponse) -> Void, failure: @escaping (Error?) -> Void )
}

class NewsAPIInterceptor: NewsAPIIntercepteable {
    
    private let requestProvider: NetworkRequestConfigurator
    private let executer: NetworkRequestExecutable
    
    init(requestProvider: NetworkRequestConfigurator = NetworkRequestConstructor(serverURL: "https://newsapi.org/v2"),
         executer: NetworkRequestExecutable = NetworkRequestExecuter()) {
        self.requestProvider = requestProvider
        self.executer = executer
    }
    
    func getHeadLines(configuration: NewsAPIHeadlinesConfiguration, success: @escaping (NewsAPIResponse) -> Void, failure: @escaping (Error?) -> Void) {
        guard let request = requestProvider.request(with: NewsAPIKeyIntegrater(endpoint: .topHeadLines(configuration: configuration))) else {
            failure(nil)
            return
        }
        executer.execute(request: request) { (result: Result<NewsAPIResponse, Error>) in
            switch result {
            case .success(let response):
                success(response)
            case .failure(let error):
                failure(error)
            }
        }
    }
    
    func getEverything(configuration: NewsAPIEverythingConfiguration, success: @escaping (NewsAPIResponse) -> Void, failure: @escaping (Error?) -> Void ) {
        
        guard let request = requestProvider.request(with: NewsAPIKeyIntegrater(endpoint: .everything(configuration: configuration))) else {
            failure(nil)
            return
        }
        executer.execute(request: request) { (result: Result<NewsAPIResponse, Error>) in
            switch result {
            case .success(let response):
                success(response)
            case .failure(let error):
                failure(error)
            }
        }
    }
}

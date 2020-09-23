//
//  RequestBuilder.swift
//  NewsApp
//
//  Created by Shailesh Aher on 22/09/20.
//  Copyright © 2020 Shailesh Aher. All rights reserved.
//

import Foundation

protocol NetworkRequestConfigurator {
    func request(with dataProvider: NetworkRequestDataProvider) -> URLRequest?
}

class NetworkRequestConstructor: NetworkRequestConfigurator {
    private let cachePolicy: URLRequest.CachePolicy
    private let timeout: TimeInterval
    private let serverURL: String
    
    init(serverURL: String,
        cachePolicy: URLRequest.CachePolicy = .reloadRevalidatingCacheData,
         timeout: TimeInterval = 10) {
        self.serverURL = serverURL
        self.cachePolicy = cachePolicy
        self.timeout = timeout
    }
    
    func request(with dataProvider: NetworkRequestDataProvider) -> URLRequest? {
        let finalURL = serverURL + dataProvider.path
        
        guard let url = URL(string: finalURL) else { return nil }
        
        var request = URLRequest(url: url, cachePolicy: cachePolicy, timeoutInterval: timeout)
        request.httpMethod = dataProvider.type.method
        switch dataProvider.type {
        case .post(let body), .patch(let body):
            request.httpBody = body.data(using: .utf8)
        default: break
        }
        return request
    }
}



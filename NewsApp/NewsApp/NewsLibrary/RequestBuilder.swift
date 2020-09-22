//
//  RequestBuilder.swift
//  NewsApp
//
//  Created by Shailesh Aher on 22/09/20.
//  Copyright © 2020 Shailesh Aher. All rights reserved.
//

import Foundation

enum RequestType {
    case get, post(body: String), patch(body: String), delete
}


protocol RequestDataProvider {
    var path: String { get }
    var type: RequestType  { get }
}

protocol RequestProvider {
    func request(with dataProvider: RequestDataProvider) -> URLRequest?
}

class RequestBuilder: RequestProvider {
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
    
    func request(with dataProvider: RequestDataProvider) -> URLRequest? {
        let finalURL = serverURL + dataProvider.path
        guard let url = URL(string: finalURL) else { return nil }
        var request = URLRequest(url: url, cachePolicy: cachePolicy, timeoutInterval: timeout)
        switch dataProvider.type {
        case .post(let body):
            request.httpMethod = "POST"
            request.httpBody = body.data(using: .utf8)
        case .patch(let body):
            request.httpMethod = "PATCH"
            request.httpBody = body.data(using: .utf8)
        default: break
        }
        return request
    }
}



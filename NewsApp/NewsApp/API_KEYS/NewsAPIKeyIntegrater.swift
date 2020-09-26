//
//  NewAPIKeyProvider.swift
//  NewsApp
//
//  Created by Shailesh Aher on 24/09/20.
//  Copyright © 2020 Shailesh Aher. All rights reserved.
//

import Foundation

struct NewsAPIKeyIntegrater: NetworkRequestDataProvider {
    var path: String {
        var components = URLComponents(string: endpoint.path)
        var queryItems = components?.queryItems ?? []
        queryItems.append(URLQueryItem(name: "apiKey", value: API_KEY.NEWS_API))
        components?.queryItems = queryItems
        return components?.url?.absoluteString ?? ""
    }
    
    var type: NetworkRequestType {
        return endpoint.type
    }
    
    private let endpoint: NewsAPIEndpoint
    
    init(endpoint: NewsAPIEndpoint) {
        self.endpoint = endpoint
    }
}

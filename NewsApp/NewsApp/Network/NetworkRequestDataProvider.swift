//
//  NetworkRequestDataProvider.swift
//  NewsApp
//
//  Created by Shailesh Aher on 23/09/20.
//  Copyright © 2020 Shailesh Aher. All rights reserved.
//

import Foundation

enum NetworkRequestType {
    case get, post(body: String), patch(body: String), delete
    
    var method: String {
        switch self {
        case .get: return "GET"
        case .post: return "POST"
        case .patch: return "PATCH"
        case .delete: return "DELETE"
        }
    }
}

protocol NetworkRequestDataProvider {
    var path: String { get }
    var type: NetworkRequestType  { get }
}

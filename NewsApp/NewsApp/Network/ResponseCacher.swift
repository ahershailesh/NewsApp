//
//  ImageCacher.swift
//  NewsApp
//
//  Created by Shailesh Aher on 26/09/20.
//  Copyright © 2020 Shailesh Aher. All rights reserved.
//

import Foundation

enum NewsAppError: Error {
    case invalidRequest
}

class CacheData {
    let response: URLResponse
    let data: Data
    
    init(response: URLResponse, data: Data) {
        self.response = response
        self.data = data
    }
}

protocol ResponseCacheable {
    func fetch(request: URLRequest, completionBlock: @escaping (Result<Data, Error>) -> Void)
    func data(for urlString: String) -> Data?
}

class ResponseCacher: ResponseCacheable {
    private let executer: NetworkRequestExecutable
    private let cache = NSCache<NSString, CacheData>()

    init(executer: NetworkRequestExecutable = NetworkRequestExecuter()) {
        self.executer = executer
    }
    
    func data(for urlString: String) -> Data? {
        return cache.object(forKey: urlString as NSString)?.data
    }
    
    func isRequestCached(request: URLRequest) -> Bool {
        guard let requestURLString = request.url?.absoluteString else {
            return false
        }
        return cache.object(forKey: requestURLString as NSString) != nil
    }
    
    func fetch(request: URLRequest, completionBlock: @escaping (Result<Data, Error>) -> Void) {
        guard let requestURLString = request.url?.absoluteString else {
            completionBlock(.failure(NewsAppError.invalidRequest))
            return
        }
        if let object = cache.object(forKey: requestURLString as NSString) {
            var headRequest = request
            headRequest.httpMethod = "HEAD"
            executer.execute(request: request) { [weak self] (data, response, error) in
                if response?.expectedContentLength == object.response.expectedContentLength {
                    completionBlock(.success(object.data))
                } else {
                    self?.fetchAndCacheData(request: request, completionBlock: completionBlock)
                }
            }
        } else {
            fetchAndCacheData(request: request, completionBlock: completionBlock)
        }
    }
    
    private func fetchAndCacheData(request: URLRequest, completionBlock: @escaping (Result<Data, Error>) -> Void) {
        executer.execute(request: request) { [weak self] (data, response, error) in
            if let data = data {
                completionBlock(.success(data))
                if let response = response, let urlString = request.url?.absoluteString {
                    self?.cache.setObject(CacheData(response: response, data: data), forKey: urlString as NSString)
                }
            } else if let error = error {
                completionBlock(.failure(error))
            } else {
                completionBlock(.failure(NewsAppError.invalidRequest))
            }
        }
    }
}

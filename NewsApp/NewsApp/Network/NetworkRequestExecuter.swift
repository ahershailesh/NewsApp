//
//  NetworkService.swift
//  NewsApp
//
//  Created by Shailesh Aher on 22/09/20.
//  Copyright © 2020 Shailesh Aher. All rights reserved.
//

import Foundation

protocol NetworkRequestExecutable {
    func execute<T: Decodable>(request: URLRequest, completionBlock: @escaping (T?, Error?) -> Void)
}

protocol RequestFetcher {
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: RequestFetcher { }

protocol Decoder {
    func decode<T>(_ type: T.Type, from data: Data) throws -> T where T : Decodable
}

extension JSONDecoder: Decoder {  }

class NetworkRequestExecuter: NetworkRequestExecutable {
    private let requestFetcher: RequestFetcher
    private let decoder: Decoder
    
    init(requestFetcher: RequestFetcher = URLSession.shared,
         decoder: Decoder = JSONDecoder()) {
        self.requestFetcher = requestFetcher
        self.decoder = decoder
    }
    
    func execute<T: Decodable>(request: URLRequest, completionBlock: @escaping (T?, Error?) -> Void) {
        let task = requestFetcher.dataTask(with: request) { [weak self] (data, response, error) in
            if error == nil,
                let data = data,
                let dataObject = try! self?.decoder.decode(T.self, from: data) {
                completionBlock(dataObject, nil)
            } else {
                completionBlock(nil, error)
            }
        }
        task.resume()
    }
}

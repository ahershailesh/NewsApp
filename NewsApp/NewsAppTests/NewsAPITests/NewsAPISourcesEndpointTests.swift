//
//  NewsAPISourcesEndpointTests.swift
//  NewsAppTests
//
//  Created by Shailesh Aher on 24/09/20.
//  Copyright © 2020 Shailesh Aher. All rights reserved.
//

import XCTest
@testable import NewsApp

class NewsAPISourcesEndpointTests: XCTestCase {
    
    func testHeadlineQuery() {
        let sourcesEndpoint = NewsAPIEndpoint.sources
        let component = URLComponents(string: sourcesEndpoint.path)!
        XCTAssertEqual("/sources", component.path, "path component must match")
        XCTAssertEqual(sourcesEndpoint.type.method, NetworkRequestType.get.method, "request type must match")
    }
}

//
//  NewAPIKeyIntegraterTests.swift
//  NewsAppTests
//
//  Created by Shailesh Aher on 24/09/20.
//  Copyright © 2020 Shailesh Aher. All rights reserved.
//

import XCTest
@testable import NewsApp

class NewAPIKeyIntegraterTests: XCTestCase {
  
    func testNilAPIKey() {
        let sourcesEndpoint = NewsAPIEndpoint.sources
        let component = URLComponents(string: sourcesEndpoint.path)!
        
        let checkKey = component.queryItems?.first(where: { $0.name == "apiKey" })
        XCTAssertNil(checkKey)
    }
    
    func testAPIKey() {
        let sourcesEndpoint = NewAPIKeyIntegrater(endpoint: .sources)
        let component = URLComponents(string: sourcesEndpoint.path)!
        
        let checkKey = component.queryItems?.first(where: { $0.name == "apiKey" })
        XCTAssertNotNil(checkKey)
    }
}

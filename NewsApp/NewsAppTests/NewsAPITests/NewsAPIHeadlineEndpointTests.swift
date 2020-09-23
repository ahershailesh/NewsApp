//
//  NewsAPIEndpointTests.swift
//  NewsAppTests
//
//  Created by Shailesh Aher on 23/09/20.
//  Copyright © 2020 Shailesh Aher. All rights reserved.
//

import XCTest
@testable import NewsApp

class NewsAPIHeadlineEndpointTests: XCTestCase {
    
    func testHeadlineQuery() {
        let testQuery = "testQuery"
        let configuration = NewsAPIHeadlinesConfiguration(query: testQuery, country: nil, category: nil, sources: nil)
        let headline = NewsAPIEndpoint.topHeadLines(configuration: configuration)
        
        let component = URLComponents(string: headline.path)!
        let checkQuery = component.queryItems!.first(where: { $0.name == "q" && $0.value == testQuery })
        XCTAssertEqual("/top-headlines", component.path, "path component dont match")
        XCTAssertNotNil(checkQuery)
    }
    
    func testHeadlineCountry() {
        let country: Country = .in
        let configuration = NewsAPIHeadlinesConfiguration(query: nil, country: country, category: nil, sources: nil)
        let headline = NewsAPIEndpoint.topHeadLines(configuration: configuration)
        
        let component = URLComponents(string: headline.path)!
        let checkCountry = component.queryItems!.first(where: { $0.name == "country" && $0.value == country.rawValue })
        XCTAssertEqual("/top-headlines", component.path, "path component dont match")
        XCTAssertNotNil(checkCountry)
    }

    func testHeadlineCategory() {
        let category: NewsApp.Category = .science
        let configuration = NewsAPIHeadlinesConfiguration(query: nil, country: nil, category: category, sources: nil)
        let headline = NewsAPIEndpoint.topHeadLines(configuration: configuration)
        
        let component = URLComponents(string: headline.path)!
        let checkCategory = component.queryItems!.first(where: { $0.name == "category" && $0.value == category.rawValue })
        XCTAssertEqual("/top-headlines", component.path, "path component dont match")
        XCTAssertNotNil(checkCategory)
    }
    
    func testHeadlineSources() {
        let source: String = "testSource"
        let configuration = NewsAPIHeadlinesConfiguration(query: nil, country: nil, category: nil, sources: source)
        let headline = NewsAPIEndpoint.topHeadLines(configuration: configuration)

        let component = URLComponents(string: headline.path)!
        let checkSource = component.queryItems!.first(where: { $0.name == "sources" && $0.value == source })
        XCTAssertEqual("/top-headlines", component.path, "path component dont match")
        XCTAssertNotNil(checkSource)
    }
}

//
//  NewsAPIEverythingEndpointTests.swift
//  NewsAppTests
//
//  Created by Shailesh Aher on 23/09/20.
//  Copyright © 2020 Shailesh Aher. All rights reserved.
//

import XCTest
@testable import NewsApp

class NewsAPIEverythingEndpointTests: XCTestCase {
    
    func testEverythingQueryParam() {
        let testQuery = "testQuery"
        let configuration = NewsAPIEverythingConfiguration(query: testQuery, queryInTitle: nil, sources: nil, domains: nil, excludeDomains: nil, from: nil, to: nil, language: nil, sortBy: nil)
        
        let everythingEndpoint = NewsAPIEndpoint.everything(configuration: configuration)
        
        let component = URLComponents(string: everythingEndpoint.path)!
        
        let checkQuery = component.queryItems!.first(where: { $0.name == "q" && $0.value == testQuery })
        XCTAssertEqual("/everything", component.path, "path component must match")
        XCTAssertEqual(everythingEndpoint.type.method, NetworkRequestType.get.method, "Request type must match")
        XCTAssertNotNil(checkQuery)
    }
    
    func testEverythingQueryInTitleParam() {
        let testQuery = "testQueryInTitle"
        let configuration = NewsAPIEverythingConfiguration(query: nil, queryInTitle: testQuery, sources: nil, domains: nil, excludeDomains: nil, from: nil, to: nil, language: nil, sortBy: nil)
        
        let everythingEndpoint = NewsAPIEndpoint.everything(configuration: configuration)
        
        let component = URLComponents(string: everythingEndpoint.path)!
        
        let checkQuery = component.queryItems!.first(where: { $0.name == "qInTitle" && $0.value == testQuery })
        XCTAssertEqual("/everything", component.path, "path component must match")
        XCTAssertEqual(everythingEndpoint.type.method, NetworkRequestType.get.method, "Request type must match")
        XCTAssertNotNil(checkQuery)
    }
    
    func testEverythingSourceParam() {
        let testSource = "testQueryInTitle"
        let configuration = NewsAPIEverythingConfiguration(query: nil, queryInTitle: nil, sources: testSource, domains: nil, excludeDomains: nil, from: nil, to: nil, language: nil, sortBy: nil)
        
        let everythingEndpoint = NewsAPIEndpoint.everything(configuration: configuration)
        
        let component = URLComponents(string: everythingEndpoint.path)!
        
        let checkSource = component.queryItems!.first(where: { $0.name == "sources" && $0.value == testSource })
        XCTAssertEqual("/everything", component.path, "path component must match")
        XCTAssertEqual(everythingEndpoint.type.method, NetworkRequestType.get.method, "Request type must match")
        XCTAssertNotNil(checkSource)
    }
    
    func testEverythingDomainParam() {
        let testDomain = "testDomain"
        let configuration = NewsAPIEverythingConfiguration(query: nil, queryInTitle: nil, sources: nil, domains: testDomain, excludeDomains: nil, from: nil, to: nil, language: nil, sortBy: nil)
        
        let everythingEndpoint = NewsAPIEndpoint.everything(configuration: configuration)
        
        let component = URLComponents(string: everythingEndpoint.path)!
        
        let checkDomain = component.queryItems!.first(where: { $0.name == "domains" && $0.value == testDomain })
        XCTAssertEqual("/everything", component.path, "path component must match")
        XCTAssertEqual(everythingEndpoint.type.method, NetworkRequestType.get.method, "Request type must match")
        XCTAssertNotNil(checkDomain)
    }
    
    func testEverythingExcludeDomainParam() {
        let testExcludeDomain = "testDomain"
        let configuration = NewsAPIEverythingConfiguration(query: nil, queryInTitle: nil, sources: nil, domains: nil, excludeDomains: testExcludeDomain, from: nil, to: nil, language: nil, sortBy: nil)
        
        let everythingEndpoint = NewsAPIEndpoint.everything(configuration: configuration)
        
        let component = URLComponents(string: everythingEndpoint.path)!
        
        let checkExcludeDomain = component.queryItems!.first(where: { $0.name == "excludeDomains" && $0.value == testExcludeDomain })
        XCTAssertEqual("/everything", component.path, "path component must match")
        XCTAssertEqual(everythingEndpoint.type.method, NetworkRequestType.get.method, "Request type must match")
        XCTAssertNotNil(checkExcludeDomain)
    }
    
    func testEverythingFromParam() {
        let dateString = "11/23/37"
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeZone = .autoupdatingCurrent
        
        let configuration = NewsAPIEverythingConfiguration(query: nil, queryInTitle: nil, sources: nil, domains: nil, excludeDomains: nil, from: formatter.date(from: dateString)!, to: nil, language: nil, sortBy: nil)
        
        let everythingEndpoint = NewsAPIEndpoint.everything(configuration: configuration)
        
        let component = URLComponents(string: everythingEndpoint.path)!
        
        let checkDate = component.queryItems!.first(where: { $0.name == "from" && $0.value == "2037-11-23"})
        XCTAssertEqual("/everything", component.path, "path component must match")
        XCTAssertEqual(everythingEndpoint.type.method, NetworkRequestType.get.method, "Request type must match")
        XCTAssertNotNil(checkDate)
    }
    
    func testEverythingToParam() {
        let dateString = "11/23/37"
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeZone = .autoupdatingCurrent
        
        let configuration = NewsAPIEverythingConfiguration(query: nil, queryInTitle: nil, sources: nil, domains: nil, excludeDomains: nil, from: nil, to: formatter.date(from: dateString)!, language: nil, sortBy: nil)
        
        let everythingEndpoint = NewsAPIEndpoint.everything(configuration: configuration)
        
        let component = URLComponents(string: everythingEndpoint.path)!
        
        let checkDate = component.queryItems!.first(where: { $0.name == "to" && $0.value == "2037-11-23"})
        XCTAssertEqual("/everything", component.path, "path component must match")
        XCTAssertEqual(everythingEndpoint.type.method, NetworkRequestType.get.method, "Request type must match")
        XCTAssertNotNil(checkDate)
    }
    
    func testEverythingLanguageParam() {
        let testLanguage: Language = .de
        
        let configuration = NewsAPIEverythingConfiguration(query: nil, queryInTitle: nil, sources: nil, domains: nil, excludeDomains: nil, from: nil, to: nil, language: testLanguage, sortBy: nil)
        
        let everythingEndpoint = NewsAPIEndpoint.everything(configuration: configuration)
        
        let component = URLComponents(string: everythingEndpoint.path)!
        
        let checkLanguage = component.queryItems!.first(where: { $0.name == "language" && $0.value == testLanguage.rawValue})
        XCTAssertEqual("/everything", component.path, "path component must match")
        XCTAssertEqual(everythingEndpoint.type.method, NetworkRequestType.get.method, "Request type must match")
        XCTAssertNotNil(checkLanguage)
    }
    
    func testEverythingSortByParam() {
        let testSortTechnique: SortingPreference = .popularity
        
        let configuration = NewsAPIEverythingConfiguration(query: nil, queryInTitle: nil, sources: nil, domains: nil, excludeDomains: nil, from: nil, to: nil, language: nil, sortBy: testSortTechnique)
        
        let everythingEndpoint = NewsAPIEndpoint.everything(configuration: configuration)
        
        let component = URLComponents(string: everythingEndpoint.path)!
        
        let checkLanguage = component.queryItems!.first(where: { $0.name == "sortBy" && $0.value == testSortTechnique.rawValue})
        XCTAssertEqual("/everything", component.path, "path component must match")
        XCTAssertEqual(everythingEndpoint.type.method, NetworkRequestType.get.method, "Request type must match")
        XCTAssertNotNil(checkLanguage)
    }
}

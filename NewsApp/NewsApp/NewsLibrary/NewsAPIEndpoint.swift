//
//  NewsAPI.swift
//  NewsApp
//
//  Created by Shailesh Aher on 22/09/20.
//  Copyright © 2020 Shailesh Aher. All rights reserved.
//

import Foundation

enum Country: String {
    case ae, ar, at, au, be, bg, br, ca, ch, cn, co, cu, cz, de, eg, fr, gb, gr, hk, hu, id, ie, il, `in`, it, jp, kr, lt, lv, ma, mx, my, ng, nl, no, nz, ph, pl, pt, ro, rs, ru, sa, se, sg, si, sk, th, tr, tw, ua, us, ve, za
}

enum Category: String {
    case business, entertainment, general, health, science, sports, technology
}

enum Language: String {
    case ar, de, en, es, fr, he, it, nl, no, pt, ru, se, ud, zh
}

enum SortingPreference: String {
    case relevancy, popularity, publishedAt
}

struct NewsAPIHeadlinesConfiguration {
    let query: String?
    let country: Country?
    let category: Category?
    let sources: String?
    let pageSize: Int = 20
    let page: Int = 1
    
    var path: String {
        var dict: [String: String] = [:]
        dict["q"] = query
        dict["sources"] = sources
        dict["country"] = country?.rawValue
        dict["category"] = category?.rawValue
        dict["pageSize"] = pageSize.description
        dict["page"] = page.description
        return dict.map { "\($0.key)=\($0.value)" }.joined(separator: "&")
    }
}

struct NewsAPIEverythingConfiguration {
    let query: String?
    let queryInTitle: String?
    let sources: String?
    let domains: String? //  (eg bbc.co.uk, techcrunch.com, engadget.com)
    let excludeDomains: String?
    let from: Date?
    let to: Date?
    let language: Language?
    let sortBy: SortingPreference?
    let pageSize: Int = 20
    let page: Int = 1
    
    var path: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        var dict: [String: String] = [:]
        dict["q"] = query
        dict["qInTitle"] = queryInTitle
        dict["sources"] = sources
        dict["domains"] = domains
        dict["excludeDomains"] = excludeDomains
        if let from = from {
            dict["from"] = dateFormatter.string(from: from)
        }
        if let to = to {
            dict["to"] = dateFormatter.string(from: to)
        }
        dict["language"] = language?.rawValue
        dict["sortBy"] = sortBy?.rawValue
        dict["pageSize"] = pageSize.description
        dict["page"] = page.description
        return dict.map { "\($0.key)=\($0.value)" }.joined(separator: "&")
    }
}

enum NewsAPIEndpoint {
    case topHeadLines(configuration: NewsAPIHeadlinesConfiguration),
    everything(configuration: NewsAPIEverythingConfiguration),
    sources
}

extension NewsAPIEndpoint: NetworkRequestDataProvider {
    var path: String {
        switch  self {
        case .topHeadLines(let configuration):
            return "/top-headlines?" + configuration.path
        case .everything(let configuration):
            return "/everything?" + configuration.path
        case .sources:
            return "/sources"
        }
    }
    
    var type: NetworkRequestType {
        return .get
    }
}

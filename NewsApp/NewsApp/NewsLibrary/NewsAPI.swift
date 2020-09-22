//
//  NewsAPI.swift
//  NewsApp
//
//  Created by Shailesh Aher on 22/09/20.
//  Copyright © 2020 Shailesh Aher. All rights reserved.
//

import UIKit

enum NewsAPIEndpoint: String {
    case topHeadLines, everything, sources
}

enum Country: String {
    case ae, ar, at, au, be, bg, br, ca, ch, cn, co, cu, cz, de, eg, fr, gb, gr, hk, hu, id, ie, il, `in`, it, jp, kr, lt, lv, ma, mx, my, ng, nl, no, nz, ph, pl, pt, ro, rs, ru, sa, se, sg, si, sk, th, tr, tw, ua, us, ve, za
}

enum Category: String {
    case business, entertainment, general, health, science, sports, technology
}

struct NewsAPIData: RequestDataProvider {
    var path: String {
        return "/\(endPoint.rawValue)"
    }
    
    var type: RequestType {
        return .get
    }
    
    private var queryParam: [String: String] = [:]
    private let endPoint: NewsAPIEndpoint
    
    init(endPoint: NewsAPIEndpoint, query: String?, country: Country = .in, category: Category, source: String?, apiKey: API_KEY = .NEWS_API) {
        self.endPoint = endPoint
        queryParam["q"] = query
        queryParam["country"] = country.rawValue
        queryParam["category"] = category.rawValue
        queryParam["apiKey"] = apiKey.rawValue
    }
}

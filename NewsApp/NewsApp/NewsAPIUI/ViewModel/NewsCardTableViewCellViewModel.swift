//
//  NewsTableViewCellViewModel.swift
//  NewsApp
//
//  Created by Shailesh Aher on 26/09/20.
//  Copyright © 2020 Shailesh Aher. All rights reserved.
//

import Foundation

protocol NewsCardTableViewCellRepresentable {
    var title: String { get }
    var description: String? { get }
    var timeStampString: String? { get }
    var source: String { get }
    
    func fetchImageData(callBack: @escaping (Data) -> Void)
    
    func openNews()
}

class NewsCardTableViewCellViewModel: NewsCardTableViewCellRepresentable {
    
    private let article: Article
    private let cacher: ResponseCacheable
    
    private let listener: NewsAPICoordinatorListener
    
    init(article: Article, cacher: ResponseCacheable = ResponseCacher(), listener: NewsAPICoordinatorListener) {
        self.article = article
        self.cacher = cacher
        self.listener = listener
    }
    
    var title: String {
        return article.title
    }
    
    var description: String? {
        return article.description
    }
    
    var timeStampString: String? {
        guard let date = article.publishedAt else { return nil }
        let component = Calendar.current.dateComponents([.minute, .hour, .day, .month, .year], from: date)
        if let minute = component.minute, minute < 60 {
            return "\(minute) minutes ago"
        } else if let hour = component.hour, hour < 24 {
            return "\(hour) hour ago"
        } else if let day = component.day, day < 24 {
            return "\(day) hour ago"
        } else if let month = component.month, month < 12 {
            return "\(month) month ago"
        } else if let year = component.year, year < 24 {
            return "\(year) hour ago"
        }
        return  "Just now"
    }
    
    var source: String {
        return article.source.name
    }
    
    func fetchImageData(callBack: @escaping (Data) -> Void) {
        guard let urlToImage = article.urlToImage,
            let url = URL(string: urlToImage) else {
                return
        }
        let request = URLRequest(url: url)
        cacher.fetch(request: request, fromCache: true) { (result) in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    callBack(data)
                }
            case .failure(_): break
            }
        }
    }
    
    func openNews() {
        listener.openNews?(article.url, article.source.name)
    }
}

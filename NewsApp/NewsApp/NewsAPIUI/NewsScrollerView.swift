//
//  NewsScrollerView.swift
//  NewsApp
//
//  Created by Shailesh Aher on 23/09/20.
//  Copyright © 2020 Shailesh Aher. All rights reserved.
//

import UIKit

extension UIView {
    class func construct<T: UIView>() -> T {
        let view = T(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
}

class NewsViewModel {
    
}

protocol ScrollViewRepresentable {
    var count: Int { get }
    func model(at index: Int) -> NewsViewModel
    
    func setupBinding(refreshCallBack: @escaping () -> Void)
}

protocol ScrollViewContentUpdater: class {
    func updateNews(news: [NewsViewModel])
}

protocol ScrollViewItemTrakeable {
    func currentViewingIndex(_ index: Int)
}

class ScrollerViewModel: ScrollViewRepresentable, ScrollViewContentUpdater {
    private var newsModels: [NewsViewModel] = []
    private var refreshCallBack: (() -> Void)?
    private let tracker: ScrollViewItemTrakeable
    
    init(tracker: ScrollViewItemTrakeable) {
        self.tracker = tracker
    }
    
    var count: Int {
        return newsModels.count
    }
    
    func model(at index: Int) -> NewsViewModel {
        tracker.currentViewingIndex(index)
        return newsModels[index]
    }
    
    func setupBinding(refreshCallBack: @escaping () -> Void) {
        self.refreshCallBack = refreshCallBack
    }
    
    func updateNews(news: [NewsViewModel]) {
        newsModels += news
        refreshCallBack?()
    }
}

class NewsScrollerView: UIView {
    private lazy var tableView: UITableView = UITableView.construct()
    private let viewModel: ScrollViewRepresentable
    
    init(viewModel: ScrollViewRepresentable) {
        self.viewModel = viewModel
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    func setup() {
        setupTableView()
        registerCells()
    }

    func newDataLoaded() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    private func setupTableView() {
        addSubview(tableView)
        tableView.dataSource = self
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    private func registerCells() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: String(describing: UITableViewCell.self))
    }
}

extension NewsScrollerView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: UITableViewCell.self))
        cell?.textLabel?.text = "Test"
        return cell ?? UITableViewCell()
    }
}

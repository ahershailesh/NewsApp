//
//  NewsScrollerView.swift
//  NewsApp
//
//  Created by Shailesh Aher on 23/09/20.
//  Copyright © 2020 Shailesh Aher. All rights reserved.
//

import UIKit

class NewsScrollerView: UIView, TableViewUpdatable {
    private lazy var tableView: UITableView = UITableView.construct()
    private var viewModel: NewsCardtableViewRepresentable
    
    init(viewModel: NewsCardtableViewRepresentable) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        self.viewModel.updatable = self
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    func setup() {
        viewModel.fetchCards()
        setupTableView()
        registerCells()
    }
    
    func update(update: TableViewUpdateType) {
        switch update {
        default:
            tableView.reloadData()
        }
    }
    
    private func setupTableView() {
        addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    private func registerCells() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: String(describing: UITableViewCell.self))
        tableView.register(NewsCardTableViewCell.self, forCellReuseIdentifier: String(describing: NewsCardTableViewCell.self))
    }
}

extension NewsScrollerView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: NewsCardTableViewCell.self)) as? NewsCardTableViewCell
        cell?.update(viewModel: viewModel.viewModels[indexPath.row])
        cell?.selectionStyle = .none
        return cell ?? UITableViewCell()
    }
}

extension NewsScrollerView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.openNews(at: indexPath.row)
    }
}

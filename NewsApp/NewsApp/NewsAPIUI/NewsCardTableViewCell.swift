//
//  NewsCardTableViewCell.swift
//  NewsApp
//
//  Created by Shailesh Aher on 26/09/20.
//  Copyright © 2020 Shailesh Aher. All rights reserved.
//

import UIKit

class NewsCardTableViewCell: UITableViewCell {

    private lazy var newsImageView: UIImageView = UIImageView.construct {
        $0.contentMode = .scaleToFill
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 4
    }
    private lazy var newsTitleLabel: UILabel = UILabel.construct {
        $0.numberOfLines = 0
    }
    private lazy var newsDescriptionLabel: UILabel = UILabel.construct {
        $0.numberOfLines = 0
    }
    private lazy var newsContentLabel: UILabel = UILabel.construct()
    private lazy var sourceButton: UIButton = UIButton.construct {
        $0.contentEdgeInsets = .init(top: 8, left: 8, bottom: 8, right: 8)
        $0.layer.cornerRadius = 4
    }
    private lazy var timeStampLabel: UILabel = UILabel.construct()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    private func setup() {
        layoutViews()
        setContentApearance()
    }
    
    private func layoutViews() {
        [newsImageView, newsTitleLabel, newsDescriptionLabel, newsContentLabel, sourceButton, timeStampLabel].forEach { contentView.addSubview($0) }
        
        NSLayoutConstraint.activate([
            newsImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            newsImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            newsImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            newsImageView.heightAnchor.constraint(equalToConstant: 200),
            
            newsTitleLabel.leadingAnchor.constraint(equalTo: newsImageView.leadingAnchor),
            newsTitleLabel.topAnchor.constraint(equalTo: newsImageView.bottomAnchor, constant: 8),
            newsTitleLabel.trailingAnchor.constraint(equalTo: newsImageView.trailingAnchor),

            newsDescriptionLabel.leadingAnchor.constraint(equalTo: newsTitleLabel.leadingAnchor),
            newsDescriptionLabel.topAnchor.constraint(equalTo: newsTitleLabel.bottomAnchor, constant: 8),
            newsDescriptionLabel.trailingAnchor.constraint(equalTo: newsTitleLabel.trailingAnchor),

            sourceButton.trailingAnchor.constraint(equalTo: newsDescriptionLabel.trailingAnchor),
            sourceButton.topAnchor.constraint(equalTo: newsDescriptionLabel.bottomAnchor, constant: 8),
            sourceButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            
            timeStampLabel.leadingAnchor.constraint(equalTo: newsDescriptionLabel.leadingAnchor),
            timeStampLabel.topAnchor.constraint(equalTo: newsDescriptionLabel.bottomAnchor, constant: 8),
            timeStampLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
        ])
    }
    
    private func setContentApearance() {
        newsTitleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        newsDescriptionLabel.font = UIFont.systemFont(ofSize: 14)
        timeStampLabel.font = UIFont.systemFont(ofSize: 14)
        sourceButton.backgroundColor = .blue
        timeStampLabel.textColor = .lightGray
    }
    
    func update(viewModel: NewsCardTableViewCellRepresentable) {
        viewModel.fetchImageData { [weak self] (data) in
            self?.newsImageView.image = UIImage(data: data)
        }
        
        newsTitleLabel.text = viewModel.title
        newsDescriptionLabel.text = viewModel.description
        timeStampLabel.text = viewModel.timeStampString
        sourceButton.setAttributedTitle(NSAttributedString(string: viewModel.source, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14),
        NSAttributedString.Key.foregroundColor: UIColor.white]), for: .normal)
    }
    
    override func prepareForReuse() {
        newsImageView.image = nil
    }
}

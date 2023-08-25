//
//  RepositoryTableViewCell.swift
//  Verity iOS
//
//  Created by Vinicius Augusto Dilay de Paula on 25/08/23.
//

import UIKit

class RepositoryTableViewCell: UITableViewCell {
    static let reuseIdentifier = "RepositoryTableViewCell"
    
    //MARK: - Properties
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .defaultLightGreenColor
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let starCounterLabel: UILabel = {
        let label = UILabel()
        label.textColor = .darkGray
        label.font = .boldSystemFont(ofSize: 16)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let starsCounterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "star.square.fill")
        imageView.tintColor = .darkGray
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.numberOfLines = 3
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let languageLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 14)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let lastUpdatedLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    
    //MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup
    private func setupUI() {
        contentView.addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        ])
        
        containerView.addSubview(nameLabel)
        containerView.addSubview(starsCounterImageView)
        containerView.addSubview(starCounterLabel)

        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            nameLabel.heightAnchor.constraint(equalToConstant: 25),
            
            starCounterLabel.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor),
            starCounterLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            
            starsCounterImageView.bottomAnchor.constraint(equalTo: starCounterLabel.bottomAnchor),
            starsCounterImageView.trailingAnchor.constraint(equalTo: starCounterLabel.leadingAnchor),
    
            nameLabel.trailingAnchor.constraint(equalTo: starsCounterImageView.leadingAnchor, constant: -8),
        ])
        
        containerView.addSubview(descriptionLabel)
        containerView.addSubview(languageLabel)
        containerView.addSubview(lastUpdatedLabel)
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            descriptionLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),

            languageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            languageLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8),

            lastUpdatedLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            lastUpdatedLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8),

            descriptionLabel.bottomAnchor.constraint(equalTo: languageLabel.topAnchor, constant: -8),
            descriptionLabel.bottomAnchor.constraint(equalTo: lastUpdatedLabel.topAnchor, constant: -8),
        ])
    }
    
    func setupData(repo: Repository) {
        nameLabel.text = repo.name
        descriptionLabel.text = repo.description
        starCounterLabel.text = " \(repo.stargazers_count ?? 0)"
        lastUpdatedLabel.text = formatToOutputDate(dateString: repo.updated_at ?? "")
        languageLabel.text = repo.language
    }
    
    private func formatToOutputDate(dateString: String )  -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        if let date = dateFormatter.date(from: dateString) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "dd/MM/yyyy"
            let formattedDate = outputFormatter.string(from: date)
            return "Updated on " + formattedDate
        }
        return ""
    }
}

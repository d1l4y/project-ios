//
//  UserDetailsInformationCardView.swift
//  Verity iOS
//
//  Created by Vinicius Augusto Dilay de Paula on 25/08/23.
//

import UIKit

enum UserDetailsInformationCardType {
    case company
    case location
    case link
    case twitter
    case followers
}

class UserDetailsInformationCardView: UIView {
    //MARK: - Properties
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 16)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 4
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    //MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup
    private func setupUI() {
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(label)
        
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            imageView.widthAnchor.constraint(equalToConstant: 24),
            imageView.heightAnchor.constraint(equalToConstant: 24),
        ])
    }
    
    func setupData(informationType: UserDetailsInformationCardType, text: String) {
        switch informationType {
        case .company:
            imageView.image = UIImage(systemName: "building.2.crop.circle.fill")
        case .location:
            imageView.image = UIImage(systemName: "house.circle.fill")
        case .link:
            imageView.image = UIImage(systemName: "link.circle.fill")
        case .twitter:
            imageView.image = UIImage(systemName: "t.square.fill")
        case .followers:
            imageView.image = UIImage(systemName: "person.2.circle.fill")
        }
        
        label.text = text
    }
}

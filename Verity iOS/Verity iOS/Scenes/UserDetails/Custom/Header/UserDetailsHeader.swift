//
//  UserDetailsHeader.swift
//  Verity iOS
//
//  Created by Vinicius Augusto Dilay de Paula on 25/08/23.
//

import UIKit

class UserDetailsHeaderView: UIView {
    //MARK: - Properties
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 20
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let userLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.textColor = .lightGray
        label.numberOfLines = 0
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
   
    private let userDetailsInformationView = {
        let view = UserDetailsInformationView()
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()
    
    private let leftStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Setup
    private func setupUI() {
        addSubview(containerView)
        containerView.fillSuperview()
        leftStackView.addArrangedSubview(profileImageView)
        leftStackView.addArrangedSubview(nameLabel)
        leftStackView.addArrangedSubview(userLabel)
        containerView.addSubview(userDetailsInformationView)
        containerView.addSubview(leftStackView)
        
        NSLayoutConstraint.activate([
            profileImageView.widthAnchor.constraint(equalToConstant: 130),
            profileImageView.heightAnchor.constraint(equalToConstant: 130),

            leftStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            leftStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16),
            leftStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            
            userDetailsInformationView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 16),
            userDetailsInformationView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            userDetailsInformationView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -16),

            leftStackView.trailingAnchor.constraint(equalTo: userDetailsInformationView.leadingAnchor, constant: -8),
            leftStackView.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.4)
        ])
    }

    func setupData(user: User) {
        self.userLabel.text = user.login
        self.nameLabel.text = user.name
        self.userDetailsInformationView.setupData(user: user)
        
        if let imageName = user.avatar_url {
            UIImage.getImage(from: imageName, completion: { [weak self] image in
                guard let self else { return }
                DispatchQueue.main.async {
                    if let image = image {
                        self.profileImageView.image = image
                    }
                }
            })
        }
    }
}


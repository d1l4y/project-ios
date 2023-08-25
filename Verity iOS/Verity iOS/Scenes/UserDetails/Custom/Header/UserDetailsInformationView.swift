//
//  UserDetailsInformationView.swift
//  Verity iOS
//
//  Created by Vinicius Augusto Dilay de Paula on 25/08/23.
//

import UIKit

class UserDetailsInformationView: UIView {
    //MARK: - Properties
    private let containerView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.alignment = .top
        view.spacing = 6
        view.distribution = .equalSpacing
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let companyInfoView: UserDetailsInformationCardView = {
        let view = UserDetailsInformationCardView()
        return view
    }()
    
    private let linkInfoView: UserDetailsInformationCardView = {
        let view = UserDetailsInformationCardView()
        return view
    }()
    
    private let twitterInfoView: UserDetailsInformationCardView = {
        let view = UserDetailsInformationCardView()
        return view
    }()
    
    private let followersInfoView: UserDetailsInformationCardView = {
        let view = UserDetailsInformationCardView()
        return view
    }()
    
    private let locationInfoView: UserDetailsInformationCardView = {
        let view = UserDetailsInformationCardView()
        return view
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
        addSubview(containerView)
        containerView.fillSuperview()
        
        containerView.addArrangedSubview(companyInfoView)
        containerView.addArrangedSubview(locationInfoView)
        containerView.addArrangedSubview(linkInfoView)
        containerView.addArrangedSubview(twitterInfoView)
        containerView.addArrangedSubview(followersInfoView)

        self.followersInfoView.isHidden = true
        self.companyInfoView.isHidden = true
        self.locationInfoView.isHidden = true
        self.linkInfoView.isHidden = true
        self.twitterInfoView.isHidden = true
    }
    
    func setupData(user: User) {
        if let twitterUsername = user.twitter_username {
            self.twitterInfoView.setupData(informationType: .twitter, text: "InfoViewTwitter".localizedFormat(twitterUsername))
            self.twitterInfoView.isHidden = false
        }
        if let company = user.company {
            self.companyInfoView.setupData(informationType: .company, text: company)
            self.companyInfoView.isHidden = false
        }
        
        if let location = user.location {
            self.locationInfoView.setupData(informationType: .location, text: location)
            self.locationInfoView.isHidden = false
        }
        if let followers = user.followers, let following = user.following {
            self.followersInfoView.setupData(informationType: .followers, text: "InfoViewFollowers".localizedFormat(followers,following))
            self.followersInfoView.isHidden = false
        }
        
        if let blog = user.blog, !blog.isEmpty {
            self.linkInfoView.setupData(informationType: .link, text: blog)
            self.linkInfoView.isHidden = false
        }
    }
}

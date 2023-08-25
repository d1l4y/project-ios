//
//  UserDetailsViewController.swift
//  Verity iOS
//
//  Created by Vinicius Augusto Dilay de Paula on 25/08/23.
//

import UIKit

class UserDetailViewController: UIViewController {
    private var viewModel: UserDetailsViewModelProtocol
    
    //MARK: - Properties
    private let userDetailsHeaderView: UserDetailsHeaderView = {
        let view = UserDetailsHeaderView()
        view.backgroundColor = .defaultDarkGreenColor
        view.layer.cornerRadius = 12
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let repositoriesLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.textAlignment = .left
        label.text = "RepositoriesLabel".localized()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var constraintTableViewHeight: NSLayoutConstraint?
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(RepositoryTableViewCell.self, forCellReuseIdentifier: RepositoryTableViewCell.reuseIdentifier)
        tableView.allowsSelection = false
        tableView.isScrollEnabled = false
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //MARK: - Initializers
    init(viewModel: UserDetailsViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }
    
    //MARK: - Setup
    private func setupUI() {
        userDetailsHeaderView.setupData(user: self.viewModel.user)
        
        view.addSubview(scrollView)
        scrollView.fillSuperview()

        scrollView.addSubview(containerView)
        containerView.addSubview(userDetailsHeaderView)
        containerView.addSubview(repositoriesLabel)
        containerView.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            userDetailsHeaderView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
            userDetailsHeaderView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            userDetailsHeaderView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            
            repositoriesLabel.topAnchor.constraint(equalTo: userDetailsHeaderView.bottomAnchor, constant: 24),
            repositoriesLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            repositoriesLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            
            tableView.topAnchor.constraint(equalTo: repositoriesLabel.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
        ])
        
        if self.viewModel.repos.isEmpty {
            self.repositoriesLabel.isHidden = true
            return
        }
        setTableHeight()
    }
    
    func setTableHeight() {
        let height = (self.viewModel.repos.count) * 120
        self.constraintTableViewHeight = self.tableView.heightAnchor.constraint(equalToConstant: CGFloat(height))
        self.constraintTableViewHeight?.isActive = true
    }
}

//MARK: - UITableViewDataSource
extension UserDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RepositoryTableViewCell.reuseIdentifier, for: indexPath) as? RepositoryTableViewCell,
indexPath.row < self.viewModel.repos.count else { return UITableViewCell() }
    
        cell.setupData(repo: self.viewModel.repos[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.repos.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}



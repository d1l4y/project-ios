//
//  UserListViewController.swift
//  Verity iOS
//
//  Created by Vinicius Augusto Dilay de Paula on 23/08/23.
//

import UIKit

class UserListViewController: UIViewController {
    var viewModel : UserListViewModelProtocol?
    
    // MARK: - Properties
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 12
        layout.minimumInteritemSpacing = 12
        layout.sectionInset = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        layout.itemSize =  CGSize(width: (view.frame.width / 2) - 24 , height:  (view.frame.height / 3.5) - 24)
        
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UserListCollectionViewCell.self, forCellWithReuseIdentifier: UserListCollectionViewCell.reuseIdentifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private lazy var searchButton: SearchButton = {
        let button = SearchButton()
           button.translatesAutoresizingMaskIntoConstraints = false
           return button
       }()
    
    //MARK: - Initializers
    init(viewModel: UserListViewModelProtocol) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupUI()
        bindUI()
    }
    
    //MARK: - Setup
    private func setupViews() {
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        
        view.addSubview(searchButton)
        NSLayoutConstraint.activate([
            searchButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            searchButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            searchButton.widthAnchor.constraint(equalToConstant: 150),            searchButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setupUI(){
        view.backgroundColor = .white
        title = "UserListTitle".localized()
    }
    
    private func bindUI() {
        viewModel?.getUsersList()
        
        viewModel?.didUpdateUsersList = {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.collectionView.reloadData()
            }
        }
        
        viewModel?.didReceiveUserDetails = { userDetails, repositories in
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                
                let viewModel = UserDetailsViewModel(user: userDetails, repos: repositories)
                let viewController = UserDetailViewController(viewModel: viewModel)
                 self.navigationController?.pushViewController(viewController, animated: true)
            }
        }
        
        viewModel?.showRequestError = { requestError in
            self.viewModel?.updateShouldFetch(to: false)
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.showAlert(message: requestError.asMessage(), completion: {
                    self.viewModel?.updateShouldFetch(to: true)
                })
            }
        }
        
        viewModel?.presentLoadingView = {
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                self.showLoadingView()
            }
        }
        
        viewModel?.removeLoadingView = {
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                self.hideLoadingView()
            }
        }
        
        searchButton.actionHandler = {
            DispatchQueue.main.async { [weak self] in
                guard let self else { return }
                self.openAlertAndSearchUser()
            }
        }
    }
    
    ///currently there is an iOS bug that shows a warning in the log when adding a textField to a Alert Controller https://stackoverflow.com/questions/75242313/uicollectionviewcell-translatesautoresizingmaskintoconstraints-property-warning
    private func openAlertAndSearchUser(){
        let alertController = UIAlertController(title: "SearchAlertTitle".localized(), message: "SearchAlertMessage".localized(), preferredStyle: .alert)
        
        alertController.addTextField { textField in
            textField.placeholder = "SearchAlertTextPlaceholder".localized()
        }
        
        let searchAction = UIAlertAction(title: "SearchAlertOkButton".localized(), style: .default) {[weak self] _ in
            if let self,
               let textField = alertController.textFields?.first,
               let username = textField.text?.replacingOccurrences(of: " ", with: "") {
                self.viewModel?.getUserDetails(user: username)
            }
        }
        let cancelAction = UIAlertAction(title: "SearchAlertCancelButton".localized(), style: .cancel, handler: nil)
        
        alertController.addAction(cancelAction)
        alertController.addAction(searchAction)
        
        present(alertController, animated: true, completion: nil)
    }
}
// MARK: - UICollectionViewDelegate
extension UserListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let viewModel = viewModel, let currentUserLogin = viewModel.users[indexPath.row].login else { return }
        viewModel.getUserDetails(user: currentUserLogin)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let scrollViewHeight = scrollView.frame.size.height
        
        if contentOffsetY > (contentHeight - scrollViewHeight) {
            viewModel?.getUsersList()
        }
    }
}

// MARK: - UICollectionViewDataSource
extension UserListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let usersCount = viewModel?.users.count else { return 0 }
        return usersCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UserListCollectionViewCell.reuseIdentifier, for: indexPath) as? UserListCollectionViewCell,
              let currentUser = viewModel?.users[indexPath.row] else {
            return UICollectionViewCell()
        }
        
        cell.setupText(currentUser.login)
        if let imageName = currentUser.avatar_url {
            UIImage.getImage(from: imageName, completion: { image in
                DispatchQueue.main.async {
                    if let image = image {
                        cell.setupImage(image)
                    }
                }
            })
        }
        return cell
    }
    
}

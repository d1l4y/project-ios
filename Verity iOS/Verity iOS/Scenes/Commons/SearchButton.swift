//
//  SearchButton.swift
//  Verity iOS
//
//  Created by Vinicius Augusto Dilay de Paula on 24/08/23.
//

import UIKit

class SearchButton: UIButton {
    var actionHandler: (() -> Void)?
    
    //MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButton() {
        let configuration = UIImage.SymbolConfiguration(weight: .bold)
        let icon = UIImage(systemName: "magnifyingglass", withConfiguration: configuration)
        setImage(icon, for: .normal)
        setTitle("SearchButtonText".localized(), for: .normal)
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        
        backgroundColor = .defaultSecondaryDarkGreenColor
        imageView?.tintColor = .white
        layer.cornerRadius = 20
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowRadius = 4
        layer.shadowOpacity = 0.5
        
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc private func buttonTapped() {
        actionHandler?()
    }
}

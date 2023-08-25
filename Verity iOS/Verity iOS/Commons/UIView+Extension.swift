//
//  UIView+Extension.swift
//  Verity iOS
//
//  Created by Vinicius Augusto Dilay de Paula on 25/08/23.
//

import UIKit

extension UIView {
    func fillSuperview(padding: UIEdgeInsets = .zero) {
        guard let superview = superview else {
            return
        }
        
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.topAnchor, constant: padding.top),
            leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: padding.left),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -padding.right),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -padding.bottom)
        ])
    }
}

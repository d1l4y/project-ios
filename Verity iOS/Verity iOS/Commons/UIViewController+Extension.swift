//
//  UIViewController+Extension.swift
//  Verity iOS
//
//  Created by Vinicius Augusto Dilay de Paula on 24/08/23.
//

import UIKit

extension UIViewController {
    func showLoadingView() {
        if let loadingView = view.subviews.first(where: { $0 is LoadingView }) {
            loadingView.removeFromSuperview()
        }
        
        let loadingView = LoadingView(frame: view.bounds)
        loadingView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        loadingView.startAnimating()
        view.addSubview(loadingView)
    }
    
    func hideLoadingView() {
        view.subviews.forEach { subview in
            if subview is LoadingView {
                (subview as? LoadingView)?.stopAnimating()
                subview.removeFromSuperview()
            }
        }
    }
    
    func showAlert(message: String, completion: (() -> Void)? = nil) {
        if presentedViewController is UIAlertController { return }
        
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertController, animated: true) {
                completion?()
            }
        
    }
}

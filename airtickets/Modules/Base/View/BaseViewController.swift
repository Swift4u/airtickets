//
//  BaseViewController.swift
//  airtickets
//
//  Created by Paulo Rodrigues on 29/12/17.
//  Copyright © 2017 MaxMilhas. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController, BaseView {
    
    // MARK: Properties
    
    var activeField: UITextField?
    fileprivate var internalScrollView: UIScrollView?
    
    // MARK: Methods
    
    func showLoading() {
        LoadingSpinner.show(NSLocalizedString("loading", comment: ""))
    }
    
    func hideLoading() {
        LoadingSpinner.hide()
    }
    
    func showNavigationBarAnimated(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func hideNavigationBarAnimated(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func showMessage(_ message: String?, withTitle title: String?) {
        let errorMessage = message ?? "GENERIC_ERROR_MESSAGE"
        let errorTitle = title ?? "ERROR"
        let errorController = UIAlertController(title: errorTitle, message: errorMessage, preferredStyle: .alert)
        errorController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(errorController, animated: true, completion: nil)
    }
    
    func showError(_ message: String?) {
        let errorMessage = message ?? "GENERIC_ERROR_MESSAGE"
        let errorController = UIAlertController(title: "TITLE_ERROR", message: errorMessage, preferredStyle: .alert)
        errorController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(errorController, animated: true, completion: nil)
    }
    
    func setupKeyboardNotifications(with scrollView: UIScrollView?) {
        internalScrollView = scrollView
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    // MARK: Keyboard Notifications
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let info = notification.userInfo,
            let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size else { return }
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height + 15.0, right: 0.0)
        
        internalScrollView?.contentInset = contentInsets
        internalScrollView?.scrollIndicatorInsets = contentInsets
        
        var aRect = view.frame
        aRect.size.height -= keyboardSize.height
        guard let activeFieldPresent = findActiveTextField(view.subviews) else { return }
        
        activeField = activeFieldPresent
        
        if !aRect.contains(activeFieldPresent.frame.origin) {
            internalScrollView?.scrollRectToVisible(activeFieldPresent.frame, animated: true)
        }
    }
    
    @objc func keyboardWillBeHidden(notification: NSNotification) {
        let contentInsets = UIEdgeInsets.zero
        internalScrollView?.contentInset = contentInsets
        internalScrollView?.scrollIndicatorInsets = contentInsets
        
        activeField = nil
    }

}

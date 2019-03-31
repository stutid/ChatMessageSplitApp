//
//  AppExtensions.swift
//  ChatMessageSplitApp
//
//  Created by Stuti on 31/03/19.
//  Copyright © 2019 iOS. All rights reserved.
//

import UIKit

extension NSObject {
    class var className: String {
        return String(describing: self)
    }
}

extension UIViewController {
    
    func showAlert(for message: String, alertTitle: String = "Alert", alertActionTitle: String = "OK") {
        let alertController = UIAlertController(title: alertTitle, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: alertActionTitle, style: .default, handler: nil)
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
}

extension UIView {
    
    func setCorners() {
        layer.cornerRadius = 10.0
        layer.masksToBounds = true
    }
    
    func setGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.zPosition = -1
        gradientLayer.colors = [
            UIColor(red: 152.0/255.0, green: 219.0/255.0, blue: 198.0/255.0, alpha: 1.0).cgColor,
            UIColor(red: 91.0/255.0, green: 200.0/255.0, blue: 172.0/255.0, alpha: 1.0).cgColor]
        layer.addSublayer(gradientLayer)
    }
}

extension UITableView {
    
    func scrollToLastRow(count: Int) {
        if count > 0 {
            let indexPath = NSIndexPath(row: count - 1, section: 0)
            scrollToRow(at: indexPath as IndexPath, at: .bottom, animated: true)
        }
    }
}

extension UITextView {
    
    func setPlaceholder() {
        let placeholderLabel = UILabel()
        placeholderLabel.text = Constants.Type_Message
        placeholderLabel.sizeToFit()
        placeholderLabel.tag = 222
        placeholderLabel.frame.origin = CGPoint(x: 5, y: (font?.pointSize)! / 2)
        placeholderLabel.textColor = UIColor.lightGray
        placeholderLabel.isHidden = !text.isEmpty
        addSubview(placeholderLabel)
        contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
    
    func checkPlaceholder() {
        let placeholderLabel = viewWithTag(222) as! UILabel
        placeholderLabel.isHidden = !text.isEmpty
    }
}

extension String {
    
    var containsWhitespace: Bool {
        return (rangeOfCharacter(from: .whitespaces) != nil)
    }
    
    func trim() -> String {
        return trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

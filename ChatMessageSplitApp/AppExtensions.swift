//
//  AppExtensions.swift
//  ChatMessageSplitApp
//
//  Created by Stuti on 31/03/19.
//  Copyright © 2019 iOS. All rights reserved.
//

import UIKit

extension UITextView {
    
    func setPadding() {
        contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
    
    func setPlaceholder() {
        
        let placeholderLabel = UILabel()
        placeholderLabel.text = Constants.Type_Message
        //        placeholderLabel.font = UIFont.italicSystemFont(ofSize: (self.font?.pointSize)!)
        placeholderLabel.sizeToFit()
        placeholderLabel.tag = 222
        placeholderLabel.frame.origin = CGPoint(x: 5, y: (font?.pointSize)! / 2)
        placeholderLabel.textColor = UIColor.lightGray
        placeholderLabel.isHidden = !text.isEmpty
        
        addSubview(placeholderLabel)
    }
    
    func checkPlaceholder() {
        let placeholderLabel = viewWithTag(222) as! UILabel
        placeholderLabel.isHidden = !text.isEmpty
    }
}


extension String {

    func trim() -> String {
        return trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

extension NSObject {
    
    class var className: String {
        return String(describing: self)
    }
}

extension UIView {
    
    func setCorners() {
        layer.cornerRadius = 10.0
        layer.masksToBounds = true
    }
}

//
//  ChatViewController.swift
//  ChatMessageSplitApp
//
//  Created by Stuti on 31/03/19.
//  Copyright © 2019 iOS. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController {

    //MARK:- Outlets
    @IBOutlet weak var tblView: UITableView!
    
    @IBOutlet weak var textviewMessage: UITextView!
    
    @IBOutlet weak var viewMessage: UIView!
    
    @IBOutlet weak var btnSend: UIButton!
    
    @IBOutlet var keyboardHeightLayoutConstraint: NSLayoutConstraint!
    
    @IBOutlet var constraintHeightTextView: NSLayoutConstraint!
    
    @IBOutlet weak var viewHeader: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerForKeyboardNotifications()
        textviewMessage.setCorners()
        textviewMessage.setPadding()
        textviewMessage.setPlaceholder()
        sendButton(isEnabled: false)
    }
    
    func sendButton(isEnabled: Bool) {
        btnSend.isEnabled = isEnabled
    }
    
    @IBAction func btnSendClicked(_ sender: UIButton) {
        
    }
    
    //MARK:- Handle UI and UITableView on keyboard show/hide
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardNotification(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    @objc func keyboardNotification(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            let endFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            let endFrameY = endFrame?.origin.y ?? 0
            let duration: TimeInterval = (userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
            let animationCurveRawNSN = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? NSNumber
            let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIView.AnimationOptions.curveEaseInOut.rawValue
            let animationCurve: UIView.AnimationOptions = UIView.AnimationOptions(rawValue: animationCurveRaw)
            
            if endFrameY >= UIScreen.main.bounds.size.height {  //Keyboard is hidden
                self.keyboardHeightLayoutConstraint?.constant = 0.0
                let edgeInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
                tblView.contentInset = edgeInset
                tblView.scrollIndicatorInsets = edgeInset
                
            } else {    //Keyboard is shown
                self.keyboardHeightLayoutConstraint?.constant = -(endFrame?.size.height)!
                
                let edgeInset = UIEdgeInsets(top: 0, left: 0, bottom: (endFrame?.size.height)!, right: 0)
                tblView.contentInset = edgeInset
                tblView.scrollIndicatorInsets = edgeInset
                
            }
            
            UIView.animate(withDuration: duration, delay: TimeInterval(0), options: animationCurve, animations: {
                self.view.layoutIfNeeded()
            }, completion: { _ in
                
            })
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

//MARK:- UITableView Datasource methods
extension ChatViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MessageCell.className) as? MessageCell
        return cell!
    }
}

//MARK:- UITextView Delegate methods
extension ChatViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        textView.checkPlaceholder()
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool{
        
        let currentText:String = textView.text
        var updatedText = (currentText as NSString).replacingCharacters(in: range, with: text)
        
        updatedText = updatedText.trim()
        
        if updatedText.isEmpty {
            
            sendButton(isEnabled: false)
            
        } else {
            
            sendButton(isEnabled: true)
        }
        
        //Dynamic height of textview and scroll after limiting to a specific height
        let cursorPosition = textView.caretRect(for: textviewMessage.selectedTextRange!.start).origin
        let currentLine = Int(cursorPosition.y / self.textviewMessage.font!.lineHeight)
        
        UIView.animate(withDuration: 0.3) {
            if currentLine == 0 {
                self.constraintHeightTextView.constant = Constants.MAX_MESSAGE_HEIGHT
            }else {
                if currentLine >= 3 {
                    self.textviewMessage.isScrollEnabled = true
                    self.constraintHeightTextView.constant = 2 * Constants.MAX_MESSAGE_HEIGHT
                    
                } else {
                    //                    self.textviewMessage.isScrollEnabled = false
                    self.constraintHeightTextView.constant = self.textviewMessage.contentSize.height + 8 // Padding
                }
            }
        }
        textviewMessage.layoutIfNeeded()
        self.view.updateConstraints()
        
        return true
    }
}

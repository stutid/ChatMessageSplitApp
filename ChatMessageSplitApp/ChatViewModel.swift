//
//  ChatViewModel.swift
//  ChatMessageSplitApp
//
//  Created by Stuti on 31/03/19.
//  Copyright © 2019 iOS. All rights reserved.
//

import Foundation

class ChatViewModel {
    
    private var arrMessages = [String]()
    
    func addMessage(_ message: String, completionHandler: @escaping (_ errorMessage: String?) -> Void) {
        
        if message.count > Constants.MAX_TWEET_SIZE && !message.containsWhitespace {
            completionHandler(Constants.Enter_Whitespace)
        }
        else {
            if message.count <= Constants.MAX_TWEET_SIZE {
                arrMessages.append(message)
                completionHandler(nil)
            }
            else {
                split(for: message, completionHandler: completionHandler)
            }
        }
    }
    
    func getMessage(at index: Int) -> String {
        return arrMessages[index]
    }
    
    func getMessageCount() -> Int {
        return arrMessages.count
    }
    
    private func split(for message: String, completionHandler: @escaping (_ errorMessage: String?) -> Void ) {
        
        if message.count > Constants.MAX_TWEET_CHARS_ALLOWED {
            completionHandler(Constants.Tweet_Too_Long)
            return
        }
        
        var string = ""
        var array = [String]()
        for (index, character) in message.enumerated() {
            if index > 0, string.count % Constants.MAX_EACH_TWEET_SIZE == 0 {
                if character == " " {
                    array.append(string)
                    string = ""
                    string.append(character)
                } else {
                    var newString = ""
                    while string.count > 0, string.last != " " {
                        let char = string.removeLast()
                        newString.append(char)
                    }
                    if string.count > 0 {
                        array.append(string)
                        string = ""
                        string.append(String(newString.reversed()))
                        string.append(character)
                        
                    } else {
                        array.removeAll()
                        break
                    }
                }
            } else {
                string.append(character)
            }
            if index == message.count - 1, string.count > 0 {
                array.append(string)
            }
        }
        var newArray = [String]()
        for (index, value) in array.enumerated() {
            var newValue = "\(index+1)/\(array.count) "
            newValue.append(value)
            newArray.append(newValue)
        }
        
        if newArray.isEmpty {
            completionHandler(Constants.Enter_Space)
        } else {
            arrMessages.append(contentsOf: newArray)
            completionHandler(nil)
        }
    }
}

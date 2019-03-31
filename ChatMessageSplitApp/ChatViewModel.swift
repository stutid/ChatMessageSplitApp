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
        
        var letters = ""
        var msgChunks = [String]()
        for (index, character) in message.enumerated() {
            if index > 0, letters.count % Constants.MAX_EACH_TWEET_SIZE == 0 {
                if character == " " {       //If 50th character is a whitespace
                    msgChunks.append(letters)
                    letters = ""
                } else {
                    var extraLetters = ""
                    while letters.count > 0, letters.last != " " {  //Remove characters until a whitespace is encountered from left
                        let char = letters.removeLast()
                        extraLetters.append(char)
                    }
                    if letters.count > 0 {          //Append when we get a whitespace
                        msgChunks.append(letters)
                        letters = ""
                        letters.append(String(extraLetters.reversed()))
                    } else {                    //No whitespace found
                        msgChunks.removeAll()
                        break
                    }
                }
            }
            letters.append(character)
            
            if index == message.count - 1, letters.count > 0 {   //If remaining characters are less than 50, append as is
                msgChunks.append(letters)
            }
        }
        
        var msgChunkWithIndicator = [String]()
        for (index, letter) in msgChunks.enumerated() {
            var indicator = "\(index+1)/\(msgChunks.count) "
            indicator.append(letter)
            msgChunkWithIndicator.append(indicator)
        }
        
        if msgChunkWithIndicator.isEmpty {
            completionHandler(Constants.Enter_Space)
        } else {
            arrMessages.append(contentsOf: msgChunkWithIndicator)
            completionHandler(nil)
        }
    }
}

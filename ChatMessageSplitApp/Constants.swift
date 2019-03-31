//
//  Constants.swift
//  ChatMessageSplitApp
//
//  Created by Stuti on 31/03/19.
//  Copyright © 2019 iOS. All rights reserved.
//

import UIKit

struct Constants {
    
    static let MAX_TWEET_SIZE = 50
    static let MAX_MESSAGE_HEIGHT: CGFloat = 40
    static let MAX_TWEETS_ALLOWED = 9
    static let MAX_PRECEEDING_CHARS = 4
    
    static let MAX_TWEET_CHARS_ALLOWED = ((MAX_TWEETS_ALLOWED * MAX_TWEET_SIZE) - (MAX_TWEETS_ALLOWED * MAX_PRECEEDING_CHARS))
    static let MAX_EACH_TWEET_SIZE = MAX_TWEET_SIZE - MAX_PRECEEDING_CHARS
    
    static let Type_Message = "Type a message"
    static let Enter_Whitespace = "Enter atleast one whitespace"
    static let Tweet_Too_Long = "Tweet is too long"
    static let Enter_Space = "Please enter space between words"
}

//
//  ChatMessageSplitAppTests.swift
//  ChatMessageSplitAppTests
//
//  Created by Stuti on 31/03/19.
//  Copyright © 2019 iOS. All rights reserved.
//

import XCTest
@testable import ChatMessageSplitApp

class ChatMessageSplitAppTests: XCTestCase {
    
    override func setUp() {
    }

    override func tearDown() {
    }
    
    func testInit() {
        let viewModel = ChatViewModel()
        XCTAssertNotNil(viewModel)
    }
    
    func testAddMessage() {
        let viewModel = ChatViewModel()
        viewModel.addMessage("Hi I am good") { (_) in
        }
        XCTAssertEqual(viewModel.getMessageCount(), 1)
    }
    
    func testGetMessage() {
        let viewModel = ChatViewModel()
        viewModel.addMessage("Hi I am good") { (_) in
        }
        XCTAssertEqual(viewModel.getMessage(at: 0), "Hi I am good")
    }
    
    func testShowMessageWhenGreaterThan50WithoutWhitespace() {
        let viewModel = ChatViewModel()
        viewModel.addMessage("IamgoodwhatareyoudoingthisweekendIhaveaplanalreadyIfyouwantyoucanjoin") { (_) in
        }
        XCTAssertEqual(viewModel.getMessageCount(), 0)
    }
    
    func testSplitMessage() {
        let viewModel = ChatViewModel()
        viewModel.addMessage("I am good. What are you doing this weekend? I have a plan already. You can join me.") { (_) in
        }
        XCTAssertEqual(viewModel.getMessageCount(), 2)
    }
    
    func testSplitMessageWithEachWordError() {
        let viewModel = ChatViewModel()
        viewModel.addMessage("Iamgood.Whatareyoudoingthisweekend?Ihaveaplan already.Youcanjoinmeifyoulikeitthatway.Ifnotthenyoucancarryon") { (_) in
        }
        XCTAssertEqual(viewModel.getMessageCount(), 0)
    }
    
    func testSplitMessageWithEachWordSuccess() {
        let viewModel = ChatViewModel()
        viewModel.addMessage("I am good. What are you doing this weekend? If I have to study.") { (_) in
        }
        XCTAssertEqual(viewModel.getMessageCount(), 2)
    }
    
    func testTweetMaxError() {
        let string = String(repeating: "Hello World", count: 500)
        let viewModel = ChatViewModel()
        viewModel.addMessage(string) {_ in }
        XCTAssertEqual(viewModel.getMessageCount(), 0)
    }
}

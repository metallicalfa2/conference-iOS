//
//  ConferenceTests.swift
//  ConferenceTests
//
//  Created by SKIXY-MACBOOK on 01/07/17.
//  Copyright © 2017 shubhamrathi. All rights reserved.
//

import XCTest
@testable import Conference

class ConferenceTests: XCTestCase {
	var loginController : UIViewController!
	
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
		loginController = LoginViewController()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
	
	func test_ifIsEmail(){
		let input = "testthisemail@gmail.com"
		let expectedOutput = true
		let emailFunction = loginController.isValidEmail(testStr: input)
		XCTAssertEqual(emailFunction, expectedOutput,
		               "email address should be correct")
	}
	
	func test_ifCanOpenUrl(){
		let input = "http://www.google.com"
		let expectedOutput = true
		let canOpenUrlFunction  = loginController.canOpenURL(string: input)
		XCTAssertEqual(canOpenUrlFunction,expectedOutput,"image url from the social account should be fine")
		
	}

    
}

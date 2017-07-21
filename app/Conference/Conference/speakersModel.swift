//
//  speakersModel.swift
//  Conference
//
//  Created by SKIXY-MACBOOK on 21/07/17.
//  Copyright © 2017 shubhamrathi. All rights reserved.
//

import UIKit

class speakersModel{

	
	var fname:String?
	var mname:String?
	var lname:String?
	var email:String?
	var title:String?
	var company:String?
	var bio:String?
	var session: [sessionModel]?
	
	init(_ fname:String,mname:String,lname:String,email:String,title:String,company:String,bio:String,session:[sessionModel]) {
		self.fname = fname
		self.mname = mname
		self.lname = lname
		self.email = email
		self.title = title
		self.company = company
		self.bio = bio
		self.session = session
	}
}

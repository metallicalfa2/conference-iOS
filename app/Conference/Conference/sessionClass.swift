//
//  sessionClass.swift
//  Conference
//
//  Created by SKIXY-MACBOOK on 08/07/17.
//  Copyright © 2017 shubhamrathi. All rights reserved.
//

import UIKit

class sessionModel{

	static let sharedInstance = sessionModel()
	
	var sessionId: String?
	var description: String?
	var endtime: Int?
	var location:String?
	var name:String?
	var sessiondate:String?
	var sessiontype:String?
	var speakers: [String]?
	var starttime: String?
	var tracks: [String]?
	
	init(id: String?, description: String?, name:String?){
		self.sessionId = id!
		self.description = description
		self.name = name
	}
	
	private init(){
		print("session initialised")
	}
}



